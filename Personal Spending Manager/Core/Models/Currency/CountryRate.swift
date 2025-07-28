//
//  CountryRate.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 08/07/2025.
//

import Foundation

struct CountryRate: Identifiable, Codable {
    var id: UUID = UUID()
    var country: String
    var dailyRate: Double
}
