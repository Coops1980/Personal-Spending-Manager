//
//  BorderedInput.swift
//  Expensify Tracker 
//
//  Created by Adrian Cooper on 09/07/2025.
//
import SwiftUI

struct BorderedInput<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}
