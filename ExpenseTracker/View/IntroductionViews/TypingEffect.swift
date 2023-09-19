//
//  TypingEffect.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 19/09/23.
//
import SwiftUI

struct TypingEffect: View {
    @State private var displayedText: String = ""
    var fullText: String
    @State private var currentIndex: String.Index?
    @Binding var startTyping: Bool
    var body: some View {
        VStack {
            Text(displayedText)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                
            
        }
        .onChange(of: startTyping) { newValue in
            if newValue {
                startTypingEffect()
            }
        }
    }
    func startTypingEffect() {
        currentIndex = fullText.startIndex
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                
                if let index = currentIndex {
                    displayedText.append(fullText[index])
                    currentIndex = fullText.index(after: index)
                    
                    if currentIndex == fullText.endIndex {
                        timer.invalidate()
                    }
                }
            }
        }
        
    }
}

struct TypingEffect_Previews: PreviewProvider {
    static var previews: some View {
        TypingEffect(fullText: "Full Text",startTyping: .constant(false))
    }
}

