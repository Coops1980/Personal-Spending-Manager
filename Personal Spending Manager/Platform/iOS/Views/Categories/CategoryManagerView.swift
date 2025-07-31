//
//  CategoryManagerView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//


import SwiftUI

struct CategoryManagerView: View {
    @StateObject private var store = CategoryStore()
    @State private var editingCategory: Category?
    @State private var newName = ""

    @State private var showDeleteAlert = false
    @State private var categoryToDelete: Category? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            Text("Categories")
                .font(.largeTitle)
                .padding(.top)

            // Input Field
            BorderedInput {
                TextField("Category Name", text: $newName)
            }

            // Alphabetically Sorted List
            VStack(spacing: 10) {
                ForEach(store.categories.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })) { category in
                    CategoryRowView(
                        category: category,
                        onEdit: {
                            editingCategory = category
                            newName = category.name
                        },
                        onDelete: {
                            categoryToDelete = category
                            showDeleteAlert = true
                        }
                    )
                }
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Delete Category"),
                    message: Text("Are you sure you want to delete this Category?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let category = categoryToDelete {
                            store.deleteCategory(category)
                        }
                        categoryToDelete = nil
                    },
                    secondaryButton: .cancel {
                        categoryToDelete = nil
                    }
                )
            }
            Spacer()

            // Action Buttons
            HStack(spacing: 12) {
                IconButton(
                    title: editingCategory == nil ? "Add Category" : "Update Category",
                    systemImage: editingCategory == nil ? "plus.circle.fill" : "square.and.pencil",
                    backgroundColor: .blue.opacity(0.1),
                    textColor: .blue,
                    fixedHeight: 50,
                    cornerRadius: 10,
                    action: handleFormSubmit
                )

                if editingCategory != nil {
                    IconButton(
                        title: "Cancel",
                        systemImage: "xmark.circle.fill",
                        backgroundColor: .red.opacity(0.1),
                        textColor: .red,
                        fixedHeight: 50,
                        cornerRadius: 10,
                        action: resetForm
                    )
                }
            }
        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity, alignment: .top)
    }

    private func handleFormSubmit() {
        let trimmedName = newName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let category = Category(id: editingCategory?.id ?? UUID(), name: trimmedName)

        if editingCategory == nil {
            store.addCategory(category)
        } else {
            store.updateCategory(category)
        }

        resetForm()
    }

    private func resetForm() {
        editingCategory = nil
        newName = ""
    }
}

// MARK: - CategoryRowView

struct CategoryRowView: View {
    var category: Category
    var onEdit: () -> Void
    var onDelete: () -> Void

    var body: some View {
        HStack {
            Text(category.name)
                .font(.headline)

            Spacer()

            HStack(spacing: 16) {
                Image(systemName: "pencil")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .onTapGesture(perform: onEdit)

                Image(systemName: "trash")
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .onTapGesture(perform: onDelete)
            }
        }
        .padding(.vertical, 6)
    }
}
