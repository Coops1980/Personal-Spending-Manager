//
//  AccountStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 13/07/2025.
//


import Foundation
import Combine

class AccountStore: ObservableObject {
    @Published var accounts: [Account] = []
    
    private let localStorageKey = "accountList"

    init() {
        self.accounts = loadAccounts()
        if accounts.isEmpty {
            accounts.append(Account(name: "Cash"))
            saveAccounts()
        }
    }

    func addAccount(_ account: Account) {
        accounts.append(account)
        saveAccounts()
    }

    func updateAccount(_ account: Account) {
        if let index = accounts.firstIndex(where: { $0.id == account.id }) {
            accounts[index] = account
            saveAccounts()
        }
    }

    func deleteAccount(_ account: Account) {
        accounts.removeAll { $0.id == account.id }
        saveAccounts()
    }

    private func saveAccounts() {
        do {
            let data = try JSONEncoder().encode(accounts)
            UserDefaults.standard.set(data, forKey: localStorageKey)
        } catch {
            print("Error saving accounts: \(error)")
        }
    }

    private func loadAccounts() -> [Account] {
        guard let data = UserDefaults.standard.data(forKey: localStorageKey),
              let decoded = try? JSONDecoder().decode([Account].self, from: data)
        else {
            return []
        }
        return decoded
    }
}
