//
//  HomeButtonLabel.swift
//  Expensify Tracker 
//
//  Created by Adrian Cooper on 09/07/2025.
//
import SwiftUI

struct HomeButtonLabel: View {
    let title: String
    let systemImage: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.system(size: 28))
            Text(title)
                .font(.headline)
        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
    }

}
