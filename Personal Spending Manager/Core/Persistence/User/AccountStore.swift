//
//  AccountStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 13/07/2025.
//


import Foundation

class AccountStore: ObservableObject {
    @Published var accounts: [String] = []

    private let filename = "ExpenseAccounts.json"

    init() {
        loadAccounts()
    }

    func addAccount(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !accounts.contains(where: { $0.caseInsensitiveCompare(trimmed) == .orderedSame }) else { return }
        accounts.append(trimmed)
        saveAccounts()
    }

    func deleteAccount(_ name: String) {
        accounts.removeAll { $0.caseInsensitiveCompare(name) == .orderedSame }
        saveAccounts()
    }

    // MARK: - Persistence
    
    private func loadAccounts() {
        let url = getURL()
        if let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode([String].self, from: data),
           !decoded.isEmpty {
            accounts = decoded
        } else {
            accounts = [] // Start empty
            saveAccounts()
        }
    }

    private func saveAccounts() {
        let url = getURL()
        if let encoded = try? JSONEncoder().encode(accounts) {
            try? encoded.write(to: url)
        }
    }

    private func getURL() -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }
}
