//
//  SecondScreen.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 19/09/23.
//

import SwiftUI

struct SecondScreen: View {
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
                
                color: "introductionThirdScreen",
                showNextView: $showNextScreen,
                bottomTextColor: .black
                
            )
            HStack {
                VStack(alignment: .leading){
                    Text("Incomes")
                        .foregroundColor(.black)
                        .font(.system(size: 50))
                        .bold()
                    TypingEffect(fullText: "Add all your Incomes, seprate them with the categories, so you can know which things are earning you more.", startTyping: $startTyping)
                        .padding(.trailing)
                }
                .padding(.leading)
                Spacer()
            }
            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(isExpanded ? 1 : 0)
            .offset(x: showText ? 0 : UIScreen.main.bounds.width)
            
        }
        .ignoresSafeArea()
    }
}

struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen(showNextScreen: .constant(false))
    }
}
