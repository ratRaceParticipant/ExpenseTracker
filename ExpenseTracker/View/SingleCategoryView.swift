//
//  SingleCategoryView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 10/09/23.
//

import SwiftUI

struct SingleCategoryView: View {
    @State var item: TransactionCategoryEntity
    @ObservedObject var vm: CoreDataViewModel
    var body: some View {
        HStack(spacing: 0) {
            
            Text(item.name ?? "")
//            Text(item.name ?? "")
                .font(.title3)
                .fontWeight(.bold)
//                .padding(.leading)
            Spacer()
            Group {
                Image(systemName: "indianrupeesign")
                Text("\(vm.getAmountByCategory(category: item))")
//                    .padding(.trailing)
            }
            .font(.title2)
            .foregroundColor(item.isIncome ? .green : .red)
        }
        
//        .padding()
//        .background(Color.secondary.opacity(0.2))
//        .cornerRadius(10)
//        .padding(.horizontal)
    }
}

struct SingleCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        SingleCategoryView(item: TransactionCategoryEntity(), vm: CoreDataViewModel())
    }
}
