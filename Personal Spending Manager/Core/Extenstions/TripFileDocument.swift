//
//  TripFileDocument.swift
//  Expensify Tracker
//
//  Created by Adrian Cooper on 22/07/2025.
//


import SwiftUI
import UniformTypeIdentifiers

struct TripFileDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }
    let url: URL

    init(url: URL) {
        self.url = url
    }

    init(configuration: ReadConfiguration) throws {
        throw CocoaError(.fileReadCorruptFile)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        try FileWrapper(url: url)
    }
}
