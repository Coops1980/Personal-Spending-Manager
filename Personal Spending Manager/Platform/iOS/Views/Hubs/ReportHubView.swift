//
//  ReportHub.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//

import SwiftUI

struct ReportHubView: View {
    @EnvironmentObject var navigationManager: NavigationManager

// MARK: - Buttons, Icons and routing
    let items: [(label: String, icon: String, screen: AppScreen)] = [
        ("Generate New Report", "doc.fill", .settings),
        ("Organise Reports", "folder", .profile),
        ("Delete Reports", "trash", .reportsHub)
                                                                // Add more screens here as your hub grows
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
// MARK: - Body of View
    var body: some View {
        VStack {
            Text("Report Hub")
                .font(.largeTitle)
                .padding()
            
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
