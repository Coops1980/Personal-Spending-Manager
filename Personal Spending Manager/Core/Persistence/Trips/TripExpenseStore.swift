//
//  TripExpenseStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 09/07/2025.
//
import Foundation
import SwiftUI

class TripExpenseStore: ObservableObject {
    @Published var expenses: [Expense] = [] {
        didSet { save() }
    }
    
    private let filename = "PersonalSpendings.json"
    
    init() {
        load()
    }
    
    func add(_ expense: Expense) {
        expenses.append(expense)
    }
    
    func update(_ expense: Expense) {
        if let index = expenses.firstIndex(where: { $0.id == expense.id }) {
            expenses[index] = expense
        }
    }
    
    func delete(_ expense: Expense) {
        expenses.removeAll { $0.id == expense.id }
    }
    
    // MARK: - Persistence
    
    private func getFileURL() -> URL {
        let manager = FileManager.default
        let docs = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent(filename)
    }
    
    private func save() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        do {
            let data = try encoder.encode(expenses)
            try data.write(to: getFileURL())
        } catch {
            print("Failed to save expenses: \(error)")
        }
    }
    
    private func load() {
        let url = getFileURL()
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            expenses = try decoder.decode([Expense].self, from: data)
        } catch {
            print("Failed to load expenses: \(error)")
        }
    }
}
