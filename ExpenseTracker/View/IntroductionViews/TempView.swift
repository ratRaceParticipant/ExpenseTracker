//
//  FirstScreen.swift
//  swiftContinuedLearning
//
//  Created by Himanshu Karamchandani on 18/09/23.
//

import SwiftUI

struct TempScreen: View {
    @Binding var showNextView: Bool
    @State var isExpanded: Bool = false
    @State var startTyping: Bool = false
    @State var showText: Bool = false
    var body: some View {
        ZStack {
            AnimatedView(isExpanded: $isExpanded, startTyping: $startTyping, showText: $showText, color: "introductionFirstScreen", showNextView: $showNextView, bottomTextColor: .white)
            
                VStack(alignment: .leading) {
                        Text("Home \nScreen")
                            .bold()
                }

            .opacity(isExpanded ? 1 : 0)
            .scaleEffect(isExpanded ? 1 : 0)
            .offset(x: showText ? 0 : UIScreen.main.bounds.width)
            Text(isExpanded.description)
            
        }
        
        .ignoresSafeArea()
    }
}

struct TemoScreen_Previews: PreviewProvider {
    static var previews: some View {
        TempScreen(showNextView: .constant(false))
    }
}
