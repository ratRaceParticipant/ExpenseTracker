//
//  SummaryView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 09/09/23.
//

import SwiftUI

struct SummaryView: View {
    @ObservedObject var vm: CoreDataViewModel
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [Color.red.opacity(0.8),
                                     Color.blue.opacity(0.8)]
                        ),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(maxWidth: .infinity)
                .frame(height: 250)
                .cornerRadius(20)
                .padding(.horizontal)
                
            VStack {
                Spacer()
                Text("₹ \(vm.getProfit())")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .offset(y:20)
                Spacer()
                HStack {
                    HStack {
                        Image(systemName: "arrow.up")
                            .foregroundColor(.green)
                            .background(
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .frame(width: 25,height: 25)
                            )
                        Text("₹\(vm.getIncomeOrExpenses(isIncome: true))")
                            .font(.title3)
                            .foregroundColor(.green)
                            .fontWeight(.bold)
                        
                    }
                    .padding(.leading)
                    Spacer()
                    HStack {
                        Image(systemName: "arrow.down")
                            .foregroundColor(.red)
                            .background(
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .frame(width: 25,height: 25)
                            )
                        Text("₹\(vm.getIncomeOrExpenses(isIncome: false))")
                            .font(.title3)
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                        
                    }
                    .padding(.trailing)
                }
                .padding(.bottom,30)
                
            }
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .cornerRadius(20)
            .padding(.horizontal)
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(vm: CoreDataViewModel())
    }
}
