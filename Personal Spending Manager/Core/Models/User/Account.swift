//
//  Account.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//
import Foundation

struct Account: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var name: String
    //var balance: Decimal?
}
