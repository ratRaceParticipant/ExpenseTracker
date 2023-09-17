//
//  RecentTransactionView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 16/09/23.
//

import SwiftUI

struct RecentTransactionView: View {
    
    @ObservedObject var vm: CoreDataViewModel = CoreDataViewModel()
    var body: some View {
        VStack {
            
            recentTransactionHeading
            recentData
        }
        
    }
    var recentTransactionHeading: some View {
        HStack {
            Text("Recent Transactions")
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
            NavigationLink {
                TransactionView(vm: vm)
            } label: {
                HStack {
                    Text("See All")
                    Image(systemName: "chevron.right")
                }
            }

            

        }
        
        .padding(.horizontal)
    }
    var recentData: some View {
        ScrollView(showsIndicators: false) {
            ForEach(vm.getDataAccordingToBatchSize(fetchLimit: 4)) { data in
                SingleTransactionItemView(giveExtraPadding: true, transactionItem: data)
                    .padding(.vertical)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
    }
}

struct RecentTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        RecentTransactionView(vm: CoreDataViewModel())
    }
}
