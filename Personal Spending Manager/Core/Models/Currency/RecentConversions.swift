//
//  RecentConversions.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 09/07/2025.
//

import Foundation

struct RecentConversion: Codable, Identifiable {
    var id = UUID()
    let amount: Double
    let from: String
    let to: String
    let result: Double
    let date: Date
}
