//
//  PersonalSpending.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 09/07/2025.
//
import Foundation

struct PersonalSpending: Identifiable, Codable, Equatable {
    var id = UUID()
    var item: String
    var amount: Double
    var date: Date
    var location: String
    var category: String
    var account: String
    var photoFilename: String? = nil

    // ✅ Custom Initializer
    init(
        id: UUID = UUID(),
        item: String,
        amount: Double,
        date: Date = Date(),
        location: String = "",
        category: String = "",
        account: String = "",
        photoFilename: String? = nil
    ) {
        self.id = id
        self.item = item
        self.amount = amount
        self.date = date
        self.location = location
        self.category = category
        self.account = account
        self.photoFilename = photoFilename
    }
}
