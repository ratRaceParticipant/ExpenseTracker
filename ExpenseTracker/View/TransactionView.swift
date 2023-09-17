//
//  TransactionView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 09/09/23.
//

import SwiftUI

struct TransactionView: View {
    @ObservedObject var vm: CoreDataViewModel
    var body: some View {
        if vm.transactionData.isEmpty {
            NoItemsView()
        } else {
            NavigationStack {
                List {
                    ForEach(vm.transactionData, id: \.self) { data in
                        SingleTransactionItemView(giveExtraPadding: false, transactionItem: data)
                    }
                    
                    .onDelete { IndexSet in
                        vm.deleteTransaction(indexSet: IndexSet)
                    }
                    
                }
                
                .listStyle(InsetListStyle())
                .navigationTitle("Transactions")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        NavigationLink {
                            AddItemView(vm: vm,category: TransactionCategoryEntity())
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                }
            }
            
        }
            
        
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(vm: CoreDataViewModel())
    }
}
