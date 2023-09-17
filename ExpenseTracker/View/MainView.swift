//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 09/09/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm = CoreDataViewModel()
    @State var currentTab: String = "Expenses"
    var body: some View {
        TabView(selection: $currentTab) {
            HomeView(vm: vm)
                .tag("Expenses")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            TransactionView(vm: vm)
                .tag("Transaction")
                .tabItem {
                    Image(systemName: "indianrupeesign.circle.fill")
                    Text("Transactions")
                }
            
            CategoryView(vm: vm)
                .tag("Category")
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Category")
                }
        }
        .tabViewStyle(DefaultTabViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
