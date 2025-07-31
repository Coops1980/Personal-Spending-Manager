//
//  UserProfile.swift
//  Expense Tracker
//
//  Created by Adrian Cooper on 08/07/2025.
//
import Foundation

enum Currency: String, CaseIterable, Codable {
    case GBP = "£"
    case USD = "$"
    case EUR = "€"
    case JPY = "¥"
    case AUD = "A$"
                            // Add more if needed
}

struct UserProfile: Codable, Equatable {
    var title: String
    var firstName: String
    var lastName: String
    var email: String
    var telephoneNumber: String
    var mobileNumber: String
    var employeeNumber: String
    var misc: String
    var monthlyBudget: Double?
    var defaultCurrency: Currency = .GBP    // New field for currency preference
}
