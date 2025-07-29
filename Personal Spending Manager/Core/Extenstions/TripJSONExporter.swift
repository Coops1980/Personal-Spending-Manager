//
//  TripJSONExporter.swift
//  Expensify Tracker
//
//  Created by Adrian Cooper on 22/07/2025.
//


import Foundation
import UniformTypeIdentifiers

struct TripJSONExporter {
    // Export basic Trip only
    static func export(trip: Trip, fileName: String = "TripExport") -> URL? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        do {
            let data = try encoder.encode(trip)
            let url = FileManager.default.temporaryDirectory
                .appendingPathComponent(fileName)
                .appendingPathExtension("json")
            try data.write(to: url)
            return url
        } catch {
            print("❌ Trip export error:", error.localizedDescription)
            return nil
        }
    }

    // Export Trip + Attachments as a bundle
    static func export(payload: TripExportPayload, fileName: String = "TripExportWithAttachments") -> URL? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        do {
            let data = try encoder.encode(payload)
            let url = FileManager.default.temporaryDirectory
                .appendingPathComponent(fileName)
                .appendingPathExtension("json")
            try data.write(to: url)
            return url
        } catch {
            print("❌ Payload export error:", error.localizedDescription)
            return nil
        }
    }
}
