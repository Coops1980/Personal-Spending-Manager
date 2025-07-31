//
//  CategoryStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 12/07/2025.
//
import Foundation

class CategoryStore: ObservableObject {
    @Published var categories: [Category] = []

    private let storageKey = "saved_categories"

    init() {
        loadCategories()
    }

    func addCategory(_ category: Category) {
        categories.append(category)
        saveCategories()
    }

    func updateCategory(_ updated: Category) {
        if let index = categories.firstIndex(where: { $0.id == updated.id }) {
            categories[index] = updated
            saveCategories()
        }
    }

    func deleteCategory(_ category: Category) {
        categories.removeAll { $0.id == category.id }
        saveCategories()
    }

    private func saveCategories() {
        if let data = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    private func loadCategories() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Category].self, from: data) {
            categories = decoded
        } else {
            categories = [
                Category(id: UUID(), name: "Food Shopping"),
                Category(id: UUID(), name: "Breakfast"),
                Category(id: UUID(), name: "Lunch"),
                Category(id: UUID(), name: "Dinner"),
                Category(id: UUID(), name: "Coffee"),
                Category(id: UUID(), name: "Snacks"),
                Category(id: UUID(), name: "Groceries"),
                Category(id: UUID(), name: "Travel"),
                Category(id: UUID(), name: "Utilities")
            ]
        }
    }
}
