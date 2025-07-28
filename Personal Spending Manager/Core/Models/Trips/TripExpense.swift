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
    var item: String
    var amount: Double
    var date: Date
    var location: String
    var category: String
    var tripDestination: String
    var photoFilename: String? = nil

    // ✅ Custom Initializer
    init(
        id: UUID = UUID(),
        item: String,
        amount: Double,
        date: Date = Date(),
        location: String = "",
        category: String = "",
        tripDestination: String,
        photoFilename: String? = nil
    ) {
        self.id = id
        self.item = item
        self.amount = amount
        self.date = date
        self.location = location
        self.category = category
        self.tripDestination = tripDestination
        self.photoFilename = photoFilename
    }
}

