//
//  WarrantyRecord.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 13/07/2025.
//
import Foundation

struct WarrantyRecord: Codable, Identifiable {
    var id = UUID()
    var expenseID: UUID
    var warrantyTitle: String
    var coveragePeriodMonths: Int
    var purchaseDate: Date
    var expiryDate: Date
    var notes: String
    var fileURL: URL?                // optional warranty file (PDF/image)
}
