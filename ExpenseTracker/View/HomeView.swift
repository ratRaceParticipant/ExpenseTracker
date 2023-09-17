//
//  HomeView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 09/09/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var vm: CoreDataViewModel
    var body: some View {
        NavigationStack {
            VStack {
                SummaryView(vm: vm)
                    .padding(.top)
                if !vm.transactionData.isEmpty {
                    RecentTransactionView(vm: vm)
                        .padding(.top)
                }
                Spacer()
            }
            
            .toolbar {
                ToolbarItem {
                    NavigationLink {
                        AddItemView(vm: vm,category: TransactionCategoryEntity())
                    } label: {
                        Image(systemName: "plus")
                    }


                }
            }
            
            .navigationTitle("Expense Tracker")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: CoreDataViewModel())
    }
}
