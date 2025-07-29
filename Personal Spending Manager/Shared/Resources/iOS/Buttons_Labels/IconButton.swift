//
//  IconButton 2.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 29/07/2025.
//


import SwiftUI

struct IconButton: View {
    var title: String
    var systemImage: String? = nil
    var action: () -> Void

    var backgroundColor: Color
    var textColor: Color
    var fixedHeight: CGFloat = 44
    var cornerRadius: CGFloat = 12

    init(
        title: String,
        systemImage: String? = nil,
        backgroundColor: Color = .blue.opacity(0.1),
        textColor: Color = .blue,
        fixedHeight: CGFloat = 44,
        cornerRadius: CGFloat = 12,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.fixedHeight = fixedHeight
        self.cornerRadius = cornerRadius
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                if let image = systemImage {
                    Image(systemName: image)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(textColor)
                }

                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(textColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .frame(height: fixedHeight)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}
