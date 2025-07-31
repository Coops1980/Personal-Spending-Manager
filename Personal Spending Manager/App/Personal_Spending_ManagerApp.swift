//
//  Personal_Spending_ManagerApp.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 28/07/2025.
//

import SwiftUI

@main
struct PersonalSpendingManagerApp: App {
    @StateObject private var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(navigationManager)
        }
    }
}

