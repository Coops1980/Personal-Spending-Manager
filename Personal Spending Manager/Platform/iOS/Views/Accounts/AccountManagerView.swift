//
//  AccountManagerView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//

import SwiftUI

struct AccountManagerView: View {
    @StateObject private var store = AccountStore()
    @State private var editingAccount: Account?
    @State private var newName = ""

    var body: some View {
        VStack(spacing: 16) {
            // Header
            Text("Accounts")
                .font(.largeTitle)
                .padding(.top)

            // Input field
            BorderedInput {
                TextField("Account Name", text: $newName)
            }

            // Account list displayed just under the input
            VStack(spacing: 10) {
                ForEach(store.accounts) { account in
                    AccountRowView(
                        account: account,
                        onEdit: {
                            editingAccount = account
                            newName = account.name
                        },
                        onDelete: {
                            store.deleteAccount(account)
                        }
                    )
                }
            }

            Spacer()

            // Action buttons at the bottom
            HStack(spacing: 12) {
                IconButton(
                    title: editingAccount == nil ? "Add Account" : "Update Account",
                    systemImage: editingAccount == nil ? "plus.circle.fill" : "square.and.pencil",
                    backgroundColor: .green.opacity(0.1),
                    textColor: .green,
                    fixedHeight: 50,
                    cornerRadius: 10,
                    action: handleFormSubmit
                )

                if editingAccount != nil {
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

        let account = Account(id: editingAccount?.id ?? UUID(), name: trimmedName)

        if editingAccount == nil {
            store.addAccount(account)
        } else {
            store.updateAccount(account)
        }

        resetForm()
    }

    private func resetForm() {
        editingAccount = nil
        newName = ""
    }
}

// MARK: - AccountRowView

struct AccountRowView: View {
    var account: Account
    var onEdit: () -> Void
    var onDelete: () -> Void

    var body: some View {
        HStack {
            Text(account.name)
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
