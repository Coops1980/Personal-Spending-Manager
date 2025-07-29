//
//  ContentView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 28/07/2025.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Hello, World!")
                .font(.title)
                .padding(.bottom, 16)

            VStack(spacing: 16) {
                IconButton(title: "Edit", systemImage: "pencil") { }
                IconButton(title: "Long Label With Icon", systemImage: "folder.fill") { }
                IconButton(title: "No Icon"){ }
                IconButton(title: "Delete", systemImage: "trash",
                    backgroundColor: .red.opacity(0.2),
                    textColor: .red
                ) {
                    // action
                }
            }
            .padding()
        }
        .padding()
    }
}
