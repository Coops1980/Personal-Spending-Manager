//
//  HubLabelView.swift
//  Expensify Tracker v2
//
//  Created by Adrian Cooper on 10/07/2025.
//
import SwiftUI

struct HubCellLabel: View {
    let title: String

    var body: some View {
        BorderedInput {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
