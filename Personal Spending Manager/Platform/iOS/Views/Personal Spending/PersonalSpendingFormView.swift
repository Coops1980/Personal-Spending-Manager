//
//  PersonalSpendingFormView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 01/08/2025.
//
import SwiftUI
import Foundation
import PhotosUI               // For photo picking on iOS/iPadOS
import UniformTypeIdentifiers // For file type specification (if using file import)
#if canImport(AppKit)
import AppKit                 // For macOS file pickers
#endif

struct PersonalSpendingFormView: View {
    @State private var spending = PersonalSpending(
        date: Date(),
        item: "",
        amount: 0.0,
        location: "",
        category: "",
        account: "",
        misc: "",
        note: ""               // Changed to non-optional
    )

    @State private var showPhotoPicker = false
    @State private var showFilePicker = false
    @State private var showNoteEditor = false
    @State private var applePayTransaction = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                DatePicker("Date", selection: $spending.date, displayedComponents: .date)

                Group {
                    TextField("Item", text: $spending.item)
                    TextField("Amount", value: $spending.amount, format: .number)
                    TextField("Location", text: $spending.location)
                    TextField("Category", text: $spending.category)
                    TextField("Account", text: $spending.account)
                    TextField("Misc", text: $spending.misc)
                    TextField("Note", text: $spending.note)
                }

                Toggle("Apple Pay Transaction", isOn: $applePayTransaction)

                HStack(spacing: 16) {
                    IconButton(title: "", systemImage: "photo", action: {
                        showPhotoPicker.toggle()
                    })

                    IconButton(title: "", systemImage: "paperclip", action: {
                        showFilePicker.toggle()
                    })

                    IconButton(title: "", systemImage: "pencil", action: {
                        showNoteEditor.toggle()
                    })
                }
            }
            .padding()
            .background(Color.white)
        }
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPickerView { filename in
                spending.photoFilename = filename
            }
        }
        .sheet(isPresented: $showFilePicker) {
            FilePickerView { fileURL in
                // Handle file logic or store string reference
            }
        }
        .sheet(isPresented: $showNoteEditor) {
            NoteEditorView(note: $spending.note)
        }
    }
}
