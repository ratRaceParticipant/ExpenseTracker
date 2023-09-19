//
//  ThirdScreen.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 19/09/23.
//

import SwiftUI

struct ThirdScreen: View {
    @Binding var isFirstTimeStarted: Bool
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @Binding var showNextScreen: Bool
    @State var isExpanded: Bool = false
    @State var startTyping: Bool = false
    @State var showText: Bool = false
    @State var shouldToggleExpand = true
    var body: some View {
        ZStack {
            
            AnimatedView(
                isExpanded: $isExpanded,
                startTyping: $startTyping,
                showText: $showText,
                
                color: "homeScreen",
                text: "START",
                showNextView: $showNextScreen,
                
                shouldToggleExpand: false,
                bottomTextColor: colorScheme == .dark ? .white : .black
                
            )
           MainView(isFirstTimeStarted: $isFirstTimeStarted)
            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(isExpanded ? 1 : 0)
            .offset(x: showText ? 0 : UIScreen.main.bounds.width)
            
        }
        .ignoresSafeArea()
    }
}

struct ThirdScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThirdScreen(isFirstTimeStarted: .constant(false), showNextScreen: .constant(false))
    }
}
