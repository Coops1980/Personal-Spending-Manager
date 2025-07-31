//
//  NavigationManager.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//


import Foundation
import SwiftUI

    /// Manages app-wide navigation state using a path-based model.
class NavigationManager: ObservableObject {
    @Published var path: [AppScreen] = []

    /// Navigate to a specific screen.
    func push(_ screen: AppScreen) {
        path.append(screen)
    }

    /// Return to the root screen.
    func popToRoot() {
        path.removeAll()
    }

    /// Pop the last screen off the stack.
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
