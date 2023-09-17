//
//  BottomBorderView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 09/09/23.
//

import SwiftUI

struct BottomBorderView: View {
    var body: some View {
        Rectangle().frame(width: nil, height: 1, alignment: .bottom).foregroundColor(Color.gray)
    }
}

struct BottomBorderView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBorderView()
    }
}
