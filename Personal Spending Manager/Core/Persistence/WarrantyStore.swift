//
//  WarrantyStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 13/07/2025.
//
import Foundation

class WarrantyStore: ObservableObject {
    @Published var warranties: [WarrantyRecord] = []

    private let filename = "Warranties.json"

    init() {
        load()
    }

    func add(_ record: WarrantyRecord) {
        warranties.append(record)
        save()
    }

    func forExpense(_ expenseID: UUID) -> WarrantyRecord? {
        warranties.first(where: { $0.expenseID == expenseID })
    }

    func delete(_ record: WarrantyRecord) {
        warranties.removeAll { $0.id == record.id }
        save()
    }

    // MARK: - Persistence
    
    private func load() {
        let url = getURL()
        guard let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([WarrantyRecord].self, from: data)
        else { return }
        warranties = decoded
    }

    private func save() {
        let url = getURL()
        if let encoded = try? JSONEncoder().encode(warranties) {
            try? encoded.write(to: url)
        }
    }

    private func getURL() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }
}
