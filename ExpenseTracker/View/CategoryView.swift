//
//  CategoryView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 10/09/23.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var vm: CoreDataViewModel
    @State var showSheet: Bool = false
    var body: some View {
        if vm.categoryData.isEmpty {
            NoItemsView()
        } else {
            NavigationStack {
                List {
                    ForEach(vm.categoryData, id: \.self) { data in
                        SingleCategoryView(item: data,vm: vm)
                            .padding(.vertical)
                    }
                    .navigationTitle("Categories")
                }
                .listStyle(InsetListStyle())
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            showSheet = true
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                }
                .sheet(isPresented: $showSheet) {
                    AddCategoryView(vm: vm)
                        .presentationDetents([.fraction(0.4)])
                }
                
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(vm: CoreDataViewModel())
    }
}
