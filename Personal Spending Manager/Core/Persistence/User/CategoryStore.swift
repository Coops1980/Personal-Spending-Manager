//
//  CategoryStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 12/07/2025.
//
import Foundation

class CategoryStore: ObservableObject {
    @Published var categories: [String] = []
    

    private let filename = "ExpenseCategories.json"
    var defaultCategories = [
        "Accomodation", "Breakfast", "Coffee", "Dinner",
        "Entertainment", "Groceries", "Lunch", "Meals",
        "Other", "Transport"
    ]

    init() {
        loadCategories()
    }

    func addCategory(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty,
              !categories.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }

        categories.append(trimmed)
        saveCategories()
    }

    func deleteCategory(_ category: String) {
        categories.removeAll {
            $0.caseInsensitiveCompare(category) == .orderedSame
        }
        saveCategories()
    }

    func resetToDefaults() {
        categories = defaultCategories
        saveCategories()
    }

    // MARK: - Persistence
    
    private func loadCategories() {
        let url = getURL()

        if let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([String].self, from: data),
           !decoded.isEmpty {
            categories = decoded
        } else {
            categories = defaultCategories
            saveCategories()
        }
    }

    private func saveCategories() {
        let url = getURL()
        if let encoded = try? JSONEncoder().encode(categories) {
            try? encoded.write(to: url)
        }
    }

    private func getURL() -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }
}
