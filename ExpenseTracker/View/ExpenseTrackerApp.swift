//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Himanshu Karamchandani on 09/09/23.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @AppStorage("isFirstTimeStarted") var isFirstTimeStarted: Bool = true
    var body: some Scene {
        WindowGroup {
            if isFirstTimeStarted {
                MainIntroductionView(isFirstTimeStarted: $isFirstTimeStarted)
            } else {
                MainView(isFirstTimeStarted: $isFirstTimeStarted)
            }
        }
        
    }
}
