//
//  AddCategoryView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 09/09/23.
//

import SwiftUI

struct AddCategoryView: View {
    @ObservedObject var vm: CoreDataViewModel
    @State var categoryText: String = ""
    @State var categoryType: String = "Income"
    @State var alertText: String = ""
    @State var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            HStack {
                Text("Add Category")
                    .font(.title)
                    .padding(.leading)
                Spacer()
            }
            TextField("Category", text: $categoryText)
                .padding(.horizontal)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.bottom)
                .overlay(alignment: .bottom,content: {
                    BottomBorderView()
                })
                .padding(.horizontal)
            Picker(selection: $categoryType) {
                Text("Income")
                    .tag("Income")
                Text("Expense")
                    .tag("Expense")
            } label: {
                
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            HStack {
                Spacer()
                Button {
                    if isCategoryTextValid() {
                        vm.addCategory(categoryName: categoryText, isIncome: categoryType == "Income")
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        showAlert = true
                    }
                } label: {
                    Text("Add Category")
                        .tint(.white)
                        .frame(width: 130,height: 60)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                }
                .padding([.trailing,.top])
                .alert("OOPS!", isPresented: $showAlert) {
                    Button("OK") {
                        showAlert = false
                    }
                } message: {
                    Text(alertText)
                }

            }


        }
        .frame(maxWidth: .infinity)
    }
    
    func isCategoryTextValid() -> Bool {
        guard vm.isCategoryNameUnique(name: categoryText) else {
            alertText = "A category with this name is already present"
            return false
            
        }
        guard !categoryText.isEmpty else {
            alertText = "Category text cannot be null"
            return false
            
        }
        return true
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(vm: CoreDataViewModel())
    }
}
