//
//  PersonalSpendingStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 09/07/2025.
//

import Foundation

class PersonalSpendingStore: ObservableObject {
    @Published var expenses: [PersonalSpending] = []

    init() {
        migrateLegacyFileIfNeeded()
        loadExpenses(for: Date()) // Load current month by default
    }

    // MARK: - Add/Delete

    func add(_ expense: PersonalSpending) {
        expenses.append(expense)
        saveExpenses(for: expense.date)
    }

    func delete(_ expense: PersonalSpending) {
        if let idx = expenses.firstIndex(of: expense) {
            expenses.remove(at: idx)
            saveExpenses(for: expense.date)
        }
    }

    // MARK: - Recent

    var recentExpenses: [PersonalSpending] {
        expenses.sorted { $0.date > $1.date }.prefix(10).map { $0 }
    }

    // MARK: - Filtering

    func expensesThisWeek() -> [PersonalSpending] {
            let calendar = Calendar.current
            let now = Date()

            guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now)),
                  let endOfWeek = calendar.date(byAdding: .day, value: 7, to: startOfWeek) else {
                return []
            }

            return expenses.filter { expense in
                expense.date >= startOfWeek && expense.date < endOfWeek
            }
        }

    func expensesThisMonth() -> [PersonalSpending] {
        let now = Date()
        guard let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: now) else { return [] }
        return expenses.filter { $0.date >= monthAgo }
    }

    // MARK: - Totals

    func totalToday() -> Double {
        let today = Date()
        return expenses
            .filter { Calendar.current.isDate($0.date, inSameDayAs: today) }
            .reduce(0) { $0 + $1.amount }
    }

    func totalThisWeek() -> Double {
        let startOfWeek = Calendar.current.date(from:
            Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        ) ?? Date()
        return expenses.filter { $0.date >= startOfWeek }
            .reduce(0) { $0 + $1.amount }
    }

    func totalThisMonth() -> Double {
        let startOfMonth = Calendar.current.date(from:
            Calendar.current.dateComponents([.year, .month], from: Date())
        ) ?? Date()
        return expenses.filter { $0.date >= startOfMonth }
            .reduce(0) { $0 + $1.amount }
    }

    // MARK: - Monthly Persistence

    func saveExpenses(for date: Date) {
        let filename = filenameFor(date: date)
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        if let encoded = try? JSONEncoder().encode(expenses) {
            try? encoded.write(to: url)
        }
    }

    func loadExpenses(for date: Date) {
        let filename = filenameFor(date: date)
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        guard let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([PersonalSpending].self, from: data) else { return }
        expenses = decoded
    }

    // MARK: - Migration Support

    private func migrateLegacyFileIfNeeded() {
        let legacyURL = getDocumentsDirectory().appendingPathComponent("PersonalSpendings.json")
        guard let data = try? Data(contentsOf: legacyURL),
              let decoded = try? JSONDecoder().decode([PersonalSpending].self, from: data),
              !decoded.isEmpty else { return }

        expenses = decoded
        saveExpenses(for: Date()) // Save to current monthly file
    }

    // MARK: - Helpers

    private func filenameFor(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        let monthKey = formatter.string(from: date)
        return "expenses-\(monthKey).json"
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
