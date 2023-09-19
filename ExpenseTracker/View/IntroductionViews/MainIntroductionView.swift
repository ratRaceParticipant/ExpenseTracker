//
//  MainIntroductionView.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 19/09/23.
//

import SwiftUI

struct MainIntroductionView: View {
    @Binding var isFirstTimeStarted: Bool
    @State var showFirstScreen: Bool = false
    @State var showSecondScreen: Bool = false
    @State var showThidScreen: Bool = false
    var body: some View {
        ZStack {
            HStack {
                Text("Expense \nTracker")
                    .font(.system(size: 50))
                    .bold()
                    .padding(.leading)
                Spacer()
            }
            FirstScreen(showNextScreen: $showFirstScreen)
            SecondScreen(showNextScreen: $showSecondScreen)
                .modifier(ViewAnimation(isShow: showFirstScreen))
            ThirdScreen(isFirstTimeStarted: $isFirstTimeStarted, showNextScreen: $showThidScreen)
                .modifier(ViewAnimation(isShow: showSecondScreen))
                
        }
        .onChange(of: showThidScreen) { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                isFirstTimeStarted = false
            }
        }
    }
}
struct ViewAnimation: ViewModifier {
    var isShow: Bool
    func body(content: Content) -> some View {
        content
            .offset(x: isShow ? 0 : 200)
            .scaleEffect(isShow ? 1 : 0, anchor: .bottomTrailing)
            .animation(Animation.spring(),value: isShow)
    }
}
struct MainIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        MainIntroductionView(isFirstTimeStarted: .constant(false))
    }
}
