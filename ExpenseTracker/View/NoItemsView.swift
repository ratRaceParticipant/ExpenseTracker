//
//  NoItemsView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 16/09/23.
//

import SwiftUI

struct NoItemsView: View {
    var body: some View {
        VStack {
            Image(systemName: "list.bullet.clipboard")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("No Items Available.")
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemsView()
    }
}
