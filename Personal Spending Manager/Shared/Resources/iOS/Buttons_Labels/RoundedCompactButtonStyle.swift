//
//  RoundedCompactButtonStyle.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 29/07/2025.
//


import SwiftUI

struct RoundedCompactButtonStyle: ButtonStyle {
    var backgroundColor: Color = .blue.opacity(0.1)
    var textColor: Color = .blue
    var fixedHeight: CGFloat = 44
    var cornerRadius: CGFloat = 12

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: fixedHeight)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}
