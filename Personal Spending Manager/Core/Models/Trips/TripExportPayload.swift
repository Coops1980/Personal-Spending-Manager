//
//  TripExportPayload.swift
//  Expensify Tracker
//
//  Created by Adrian Cooper on 23/07/2025.
//


import Foundation

struct TripExportPayload: Codable {
    var trip: Trip  // ✅ mutable so we can tag notes like "[Imported for testing]"
    let attachments: [TripFileAttachment]
}
