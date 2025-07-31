//
//  RootView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//


import SwiftUI

struct RootView: View {
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            HomeView()
                .navigationDestination(for: AppScreen.self) { screen in
                    switch screen {
                    case .homeview:
                        HomeView()
                    case .settings:
                        SettingsHub()
                    case .profile:
                        ProfileView()
                    case .tripHub:
                        TripHubView()
                    case .personalExpensesHub:
                        PersonalExpensesHub()
                    case .reportsHub:
                        ReportHubView()
                    case .accounts:
                        AccountManagerView()
                    case ._category:
                        CategoryManagerView()
                    }
                }
        }
        .environmentObject(navigationManager)
    }
}
