//
//  TripStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 09/07/2025.
//

import Foundation
import SwiftUI

class TripStore: ObservableObject {
    @Published var trips: [Trip] = [] {
        didSet { save() }
    }
    
    private let filename = "trips.json"
    
    init() {
        // clearSaveTrips()
        load()
    }
    
    func addTrip(_ trip: Trip) {
        trips.append(trip)
    }
    
    func clearSaveTrips() {
        let url = getFileURL()
        try? FileManager.default.removeItem(at: url)
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
            let data = try encoder.encode(trips)
            try data.write(to: getFileURL())
        } catch {
            print("Failed to save trips: \(error)")
        }
    }
    
    private func load() {
        let url = getFileURL()
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            trips = try decoder.decode([Trip].self, from: data)
        } catch {
            print("Failed to load trips: \(error)")
        }
    }
    
    func delete(_ trip: Trip) {
        if let index = trips.firstIndex(where: { $0.id == trip.id }) {
            trips.remove(at: index)
        }
    }
        
}
