//
//  NoteEditorView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 01/08/2025.
//


import SwiftUI

struct NoteEditorView: View {
    @Binding var note: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextEditor(text: $note)
                    .padding()
                    .frame(maxHeight: .infinity)
                    .background(Color.white)
                    .cornerRadius(8)

                Button("Save") {
                    dismiss()  // Closes the sheet
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
            }
            .padding()
            .navigationTitle("Edit Note")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white)
        }
    }
}
