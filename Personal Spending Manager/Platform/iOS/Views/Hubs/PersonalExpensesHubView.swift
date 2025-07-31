//
//  SpendingHubView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//


import SwiftUI

struct PersonalExpensesHub: View {
    @EnvironmentObject var navigationManager: NavigationManager

// MARK: - Buttons, Icons and routing
    let items: [(label: String, icon: String, screen: AppScreen)] = [
        ("Add Spending", "creditcard.fill", .personalspending),
        ("Edit Spending", "creditcard", .profile),
        ("Report Hub", "doc", .reportsHub)
                                                                // Add more screens here as your hub grows
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
// MARK: - Main Body
    var body: some View {
        VStack(spacing: 20) {
            Text("Personal Spending Hub")
                .font(.title)
                .fontWeight(.medium)
                .padding(.top)
            
                Spacer()

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items, id: \.label) { item in
                    IconButton(
                        title: item.label,
                        systemImage: item.icon,
                        backgroundColor: .blue.opacity(0.1),
                        textColor: .blue,
                        fixedHeight: 50,
                        cornerRadius: 10
                    ) {
                        navigationManager.push(item.screen)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
