//
//  AnimatedView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 19/09/23.
//

import SwiftUI

struct AnimatedView: View {
    
    @Binding var isExpanded: Bool
    @Binding var startTyping: Bool
    @Binding var showText: Bool
    
    var color: String
    var text: String = "NEXT"
    var showNextView: Binding<Bool>?
    var shouldToggleExpand: Bool = true
    @State var bottomTextColor: Color
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(Color(color))
                    .cornerRadius(isExpanded ? 30 : 100)
                    .padding()
                    .frame(width: isExpanded ? max(geometry.size.width, geometry.size.height) * 1.5 : 200,
                           height:isExpanded ? max(geometry.size.width, geometry.size.height) * 1.5 : 200)
                
                if !isExpanded {
                    HStack {
                        Text(text)
                        Image(systemName: "arrow.right")
                    }
                    .bold()
                    .foregroundColor(bottomTextColor)
                }
               
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottomTrailing)
            .offset(x: isExpanded ? -25 : 25, y: isExpanded ? -75 : 25)
            .edgesIgnoringSafeArea(.bottom)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.8)) {
                if shouldToggleExpand {
                    
                    isExpanded.toggle()
                    showText.toggle()
                } else {

                    isExpanded = true
                    showText = true
                }
                
                startTyping = true
                if let showNextViewBinding = showNextView {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showNextViewBinding.wrappedValue.toggle()
                    }
                }
            }
        }
    }
}


