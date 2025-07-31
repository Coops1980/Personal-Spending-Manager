//
//  TransactionAssetManager.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 01/08/2025.
//


import Foundation
import SwiftUI

struct TransactionAssetManager {
    static let assetFolderName = "SpendingAssets"

    // Returns the folder URL tied to a transaction UUID
    static func folderURL(for transactionID: UUID) -> URL {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(assetFolderName).appendingPathComponent(transactionID.uuidString)
    }

    // Saves a file (like image or PDF) into the transaction’s folder
    static func save(data: Data, filename: String, transactionID: UUID) throws -> URL {
        let folder = folderURL(for: transactionID)
        try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        let fileURL = folder.appendingPathComponent(filename)
        try data.write(to: fileURL)
        return fileURL
    }

    // Loads a file if it exists
    static func load(filename: String, transactionID: UUID) -> URL? {
        let fileURL = folderURL(for: transactionID).appendingPathComponent(filename)
        return FileManager.default.fileExists(atPath: fileURL.path) ? fileURL : nil
    }

    // Lists all filenames for a given transaction
    static func listAllAssets(transactionID: UUID) -> [URL] {
        let folder = folderURL(for: transactionID)
        guard let contents = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil) else {
            return []
        }
        return contents
    }

    // Deletes an asset from the folder
    static func delete(filename: String, transactionID: UUID) throws {
        let fileURL = folderURL(for: transactionID).appendingPathComponent(filename)
        try FileManager.default.removeItem(at: fileURL)
    }
}
