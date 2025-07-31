//
//  CurrencyManager.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 28/07/2025.
//

import SwiftUI
import Foundation

class CurrencyManager: ObservableObject {
    @Published var rates: [String: Double] = [:]
    @Published var lastUpdated: Date?
    @Published var error: CurrencyRateError?

    func loadRates(for base: String = "GBP") {
        CurrencyRateService.shared.fetchRates(baseCurrency: base) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let (rates, date)):
                    self.rates = rates
                    self.lastUpdated = date
                case .failure(let error):
                    self.error = error
                }
            }
        }
    }
}
