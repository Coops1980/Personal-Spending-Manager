//
//  TripExpense.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 09/07/2025.
//

import Foundation
import UIKit

struct Expense: Identifiable, Codable, Equatable {
    var id = UUID()
    var date: Date
    var item: String
    var amount: Double
    var location: String
    var category: String
    var tripDestination: String
    var photoFilename: String? = nil

    // ✅ Custom Initializer
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        item: String,
        amount: Double,
        location: String = "",
        category: String = "",
        tripDestination: String,
        photoFilename: String? = nil
    ) {
        self.id = id
        self.date = date
        self.item = item
        self.amount = amount
        self.location = location
        self.category = category
        self.tripDestination = tripDestination
        self.photoFilename = photoFilename
    }
}

