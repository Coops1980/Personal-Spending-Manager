//
//  TripDetailView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//


import SwiftUI

struct TripHubView: View {
    @EnvironmentObject var navigationManager: NavigationManager

// MARK: - Buttons, Icons and routing
    let items: [(label: String, icon: String, screen: AppScreen)] = [
        ("Edit Trip", "aeroplane.fill", .settings)                  //To be changed when trips are made
        
                                                           
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

// MARK: - Main Body

    var body: some View {
        VStack {
            Text("Trip Hub")
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
