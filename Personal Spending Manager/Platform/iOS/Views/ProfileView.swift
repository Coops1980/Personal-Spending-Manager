//
//  ProfileView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//


import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var navigationManager: NavigationManager

//MARK: Setting profile to default settings
    
    @State private var profile = UserProfile(
        title: "",
        firstName: "",
        lastName: "",
        email: "",
        telephoneNumber: "",
        mobileNumber: "",
        employeeNumber: "",
        misc: "",
        monthlyBudget: nil
    )
    
// MARK: Buttons, Icons and routing

    let items: [(label: String, icon: String, screen: AppScreen)] = [
        ("Settings", "gearshape.fill", .settings)
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

// MARK: Main Body

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("User Profile")
                    .font(.largeTitle)
                    .padding(.top)

                // 👤 Profile Form Section
                Form {
                    Section(header: Text("Basic Info")) {
                        TextField("Title", text: $profile.title)
                        TextField("First Name", text: $profile.firstName)
                        TextField("Last Name", text: $profile.lastName)
                        TextField("Email", text: $profile.email)
                            .keyboardType(.emailAddress)
                    }

                    Section(header: Text("Contact Details")) {
                        TextField("Telephone Number", text: $profile.telephoneNumber)
                            .keyboardType(.phonePad)
                        TextField("Mobile Number", text: $profile.mobileNumber)
                            .keyboardType(.phonePad)
                    }

                    Section(header: Text("Employment & Other")) {
                        TextField("Employee Number", text: $profile.employeeNumber)
                        TextField("Misc", text: $profile.misc)
                    }

                    Section(header: Text("Budget")) {
                        TextField("Monthly Budget", value: $profile.monthlyBudget, formatter: NumberFormatter.currency)
                            .keyboardType(.decimalPad)
                    }

                    Button("Save Profile") {
                        // Future hook to UserProfileStore
                        print("Saved profile:", profile)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }

// MARK: Navigation Buttons
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(items, id: \.label) { item in
                        IconButton(
                            title: item.label,
                            systemImage: item.icon,
                            backgroundColor: .blue.opacity(0.1),
                            textColor: .blue,
                            fixedHeight: 50,
                            cornerRadius: 10
                        ) {
                            navigationManager.push(item.screen)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding()
        }
    }
}

// MARK: Extenstions

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
