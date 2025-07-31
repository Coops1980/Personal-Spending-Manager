//
//  HomeView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationManager: NavigationManager

// MARK: Buttons, Icons and routing
    let items: [(label: String, icon: String, screen: AppScreen)] = [
        ("Trip Hub", "airplane", .tripHub),
        ("Personal Expenses", "creditcard", .personalExpensesHub),
        ("Reports", "doc", .reportsHub),
        ("Settings", "gearshape.fill", .settings)
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
// MARK: Main Body
    var body: some View {
        VStack {
            Text("Personal Spending Manager")                           // Title up top
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)

            Spacer()                                                    // Pushes grid to the bottom

            LazyVGrid(columns: columns, spacing: 16) {                  // Button grid at the bottom
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
            .padding(.bottom)
        }
        .padding()
    }

}
