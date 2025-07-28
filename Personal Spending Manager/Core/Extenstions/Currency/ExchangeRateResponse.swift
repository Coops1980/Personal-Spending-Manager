//
//  ExchangeRateResponse.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 28/07/2025.
//


import Foundation

struct ExchangeRateResponse: Codable {
    let baseCode: String
    let rates: [String: Double]
    let timeLastUpdateUTC: String

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case rates
        case timeLastUpdateUTC = "time_last_update_utc"
    }
}

enum CurrencyRateError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    case invalidDate
}

final class CurrencyRateService {
    
    static let shared = CurrencyRateService()
    private init() {}
    
    private let endpointBase = "https://open.er-api.com/v6/latest/"

    func fetchRates(
        baseCurrency: String = "GBP",
        completion: @escaping (Result<(rates: [String: Double], updated: Date), CurrencyRateError>) -> Void
    ) {
        guard let url = URL(string: endpointBase + baseCurrency) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidURL))
                return
            }
            do {
                let decoded = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                guard let updated = DateFormatter.currencyRateDateFormatter.date(from: decoded.timeLastUpdateUTC) else {
                    completion(.failure(.invalidDate))
                    return
                }
                completion(.success((decoded.rates, updated)))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }.resume()
    }
}

extension DateFormatter {
    static let currencyRateDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
