//
//  Trip.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 09/07/2025.
//

import Foundation
import SwiftUI

struct Trip: Identifiable, Codable, Equatable {
    let id: UUID
    var destination: String
    var country: String
    var accommodation: String
    var notes: String
    var startDate: Date
    var endDate: Date
    var dailyAllowance: Double
    var currency: String

    // MARK: - Computed Properties

    var numberOfDays: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day], from: start, to: end)
        return max(1, (components.day ?? 0) + 1)
    }

    var totalAllowance: Double {
        dailyAllowance * Double(numberOfDays)
    }

    // MARK: - Mock Data

    static let mock = Trip(
        id: UUID(),
        destination: "Tokyo",
        country: "",
        accommodation: "Shinjuku Grand Hotel",
        notes: "Explore sushi spots and tech districts.",
        startDate: Date(), // Now
        endDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
        dailyAllowance: 100.0,
        currency: "GBP"
    )
}


