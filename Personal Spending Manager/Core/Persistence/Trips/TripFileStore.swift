//
//  TripFileStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 13/07/2025.
//


import Foundation
import SwiftUI
import UniformTypeIdentifiers

class TripFileStore: ObservableObject {
    @Published var files: [TripFileAttachment] = []

    private let filename = "TripFiles.json"

    init() {
        loadFiles()
    }

    func addFile(_ file: TripFileAttachment) {
        files.append(file)
        saveFiles()
    }

    func files(forTrip tripID: UUID) -> [TripFileAttachment] {
        files.filter { $0.tripID == tripID }
    }

    func delete(_ file: TripFileAttachment) {
        files.removeAll { $0.id == file.id }
        saveFiles()
    }
    
    func editFile(_ updatedFile: TripFileAttachment) {
        guard let index = files.firstIndex(where: { $0.id == updatedFile.id }) else {
            print("Edit failed: file not found")
            return
        }

        files[index] = updatedFile
        saveFiles()
    }

    // MARK: - Persistence
    
    private func loadFiles() {
        let url = getURL()
        guard let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([TripFileAttachment].self, from: data) else { return }
        files = decoded
    }

    private func saveFiles() {
        let url = getURL()
        if let encoded = try? JSONEncoder().encode(files) {
            try? encoded.write(to: url)
        }
    }

    private func getURL() -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }
}

// 📎 Struct to represent each file
struct TripFileAttachment: Codable, Identifiable {
    var id = UUID()
    let tripID: UUID
    let name: String
    let url: URL
    let date: Date
}
