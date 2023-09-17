//
//  SingleTransactionItemView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 09/09/23.
//

import SwiftUI

struct SingleTransactionItemView: View {
    @State var giveExtraPadding: Bool
    @State var transactionItem: TransactionEntity
    var body: some View {
        HStack {
            Image(systemName: transactionItem.isIncome ? "plus" : "minus")
                .foregroundColor(transactionItem.isIncome ? .green : .red)
                .font(.title3)
                .padding(.leading, giveExtraPadding ? 10 : 0)
            VStack(alignment:.leading) {
                Text("\(transactionItem.name ?? "" )")
                    .font(.title3)
                    .fontWeight(.bold)
                HStack {
                    Text("\(transactionItem.category?.name ?? ""):")
                        .fontWeight(.bold)
                    Text("\(transactionItem.transactionDate ?? Date(), format: Date.FormatStyle().year().month().day() )")
                }
                
                
            }
            Spacer()
            
            Text("₹\(transactionItem.amount)")
                .font(.title2)
                .padding(.trailing, giveExtraPadding ? 10 : 0)
        }
        
//        .padding(.vertical)
//        .background(Color.secondary.opacity(0.2))
//        .cornerRadius(10)
        
        
    }
}

struct SingleTransactionItemView_Previews: PreviewProvider {
    static var previews: some View {
        SingleTransactionItemView(giveExtraPadding: true, transactionItem: TransactionEntity())
    }
}
