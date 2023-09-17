//
//  AddItemView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 09/09/23.
//

import SwiftUI


class NumberOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter{ $0.isNumber }
            if value != filtered {
                value = filtered
            }
        }
    }
}

struct AddItemView: View {
    @ObservedObject var vm: CoreDataViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var transactionText: String = ""
    @State var transactionAmount = NumberOnly()
    @State var transactionDate: Date = Date()
    @State var selectedCategoryText: String?
    @State var showAddCategory: Bool = false
    @State var category: TransactionCategoryEntity
    @State var showAlert: Bool = false
    @State var tempAmount: Int?
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                TextField("Transaction Text", text: $transactionText)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .padding()
                if transactionText.count > 50 {
                    HStack {
                        Text("Transaction text cannot be more than 50 characters")
                            .font(.caption)
                            .padding(.leading)
                            .foregroundColor(.red)
                            .offset(y:-15)
                        Spacer()
                    }
                }
                
                    
                HStack {
                    TextField("Enter Amount ₹", value: $tempAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                DatePicker(
                    "Transaction Date",
                    selection: $transactionDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxWidth: .infinity)
                .frame(height: 290)
                .padding()
                HStack {
                  
                    menuComponent
                    
                    Button("+ Add Category") {
                        showAddCategory = true
                    }
                    .buttonStyle(.borderless)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    
                    addButton
                }
                .padding(.horizontal)
                Spacer()
                    
            }
            .navigationTitle("Add Transaction")
            .sheet(isPresented: $showAddCategory) {
                AddCategoryView(vm: vm)
                    .presentationDetents([.fraction(0.4)])
            }
            
        }
//        .onAppear {
//            category  = TransactionCategoryEntity(context: vm.container.viewContext)
//        }
        
    }
    var menuComponent: some View {
        Menu {
            ForEach(vm.categoryData, id: \.self) { data in
                Button {
                    selectedCategoryText = data.name
                    category = data
                } label: {
                    Text(data.name ?? "")
                }

            }
        } label: {
            Text(selectedCategoryText ?? "Select Category")
                
              
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
    }
    var addButton: some View {
        Button {
           addTransactionButtonAction()
            
        } label: {
            Text("Add Transaction")
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        
        .alert("Enter complete and valid data", isPresented: $showAlert) {
            Button("OK") {
                showAlert = false
            }
        } message: {
            Text("Some fields might be empty or values might be invalid")
        }
    }
    
    func addTransactionButtonAction() {
        if !isFieldValueCorrect() {
            showAlert = true
        } else {
            vm.addTransaction(
                transactionName: transactionText,
                transactionAmount: Int64(tempAmount ?? 0),
                transactionDate: transactionDate,
                category: category,
                isIncome: category.isIncome
            )
            presentationMode.wrappedValue.dismiss()
        }
        
    }
    func isFieldValueCorrect() -> Bool {
        guard !transactionText.isEmpty &&
                transactionText.count < 50 &&
                tempAmount != 0
                else { return false }
        guard selectedCategoryText != nil else {return false}
        
        return true
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(vm: CoreDataViewModel(), category: TransactionCategoryEntity())
    }
}
