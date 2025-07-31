//
//  PersonalSpending.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 09/07/2025.
//
import Foundation

struct PersonalSpending: Identifiable, Codable, Equatable {
    var id = UUID()
    var date: Date
    var item: String
    var amount: Double
    var location: String
    var category: String
    var account: String
    var photoFilename: String? = nil
    var misc: String

    // ✅ Custom Initializer
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        item: String,
        amount: Double,
        location: String = "",
        category: String = "",
        account: String = "",
        photoFilename: String? = nil,
        misc: String
    ) {
        self.id = id
        self.date = date
        self.item = item
        self.amount = amount
        self.location = location
        self.category = category
        self.account = account
        self.photoFilename = photoFilename
        self.misc = misc
    }
}
