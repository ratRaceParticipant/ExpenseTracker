//
//  FirstScreen.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 19/09/23.
//

import SwiftUI

struct FirstScreen: View {
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
                
                color: "introductionFirstScreen",
                
                showNextView: $showNextScreen,
                bottomTextColor: .black
                
                
            )
            HStack {
                VStack(alignment: .leading){
                    Text("Expenses")
                        .foregroundColor(.black)
                        .font(.system(size: 50))
                        .bold()
                    TypingEffect(fullText: "Add all your expenses, seprate them with the categories, so you can know which thing you are expending more on.", startTyping: $startTyping)
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

struct FirstScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreen(showNextScreen: .constant(false))
    }
}
