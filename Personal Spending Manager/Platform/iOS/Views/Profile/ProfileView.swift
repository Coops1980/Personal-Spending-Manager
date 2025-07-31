//
//  ProfileView.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @ObservedObject private var store = UserProfileStore()
    
    @State private var showingSaveConfirmation = false
    @State private var showingClearConfirmation = false
    
    let items: [(label: String, icon: String, screen: AppScreen)] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("User Profile")
                    .font(.largeTitle)
                    .padding(.top)
                
                VStack(spacing: 12) {
                    Group {
                        BorderedInput {
                            TextField("Title", text: $store.profile.title)
                        }
                        BorderedInput {
                            TextField("First Name", text: $store.profile.firstName)
                        }
                        BorderedInput {
                            TextField("Last Name", text: $store.profile.lastName)
                        }
                        BorderedInput {
                            TextField("Email", text: $store.profile.email)
                                .keyboardType(.emailAddress)
                        }
                    }
                    
                    Group {
                        BorderedInput {
                            TextField("Telephone Number", text: $store.profile.telephoneNumber)
                                .keyboardType(.phonePad)
                        }
                        BorderedInput {
                            TextField("Mobile Number", text: $store.profile.mobileNumber)
                                .keyboardType(.phonePad)
                        }
                    }
                    
                    Group {
                        BorderedInput {
                            TextField("Employee Number", text: $store.profile.employeeNumber)
                        }
                        BorderedInput {
                            TextField("Misc", text: $store.profile.misc)
                        }
                    }
                    
                    BorderedInput {
                        TextField(
                            "Monthly Budget",
                            value: $store.profile.monthlyBudget,
                            formatter: NumberFormatter.currency
                        )
                        .keyboardType(.decimalPad)
                    }
                }
                // MARK: - Buttons
                
                HStack(spacing: 16) {
                    Button("Clear Profile") {
                        showingClearConfirmation = true
                    }
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .alert(isPresented: $showingClearConfirmation) {
                        Alert(
                            title: Text("Are you sure?"),
                            message: Text("This will erase your profile data."),
                            primaryButton: .destructive(Text("Yes, Clear")) {
                                store.clearProfile()
                            },
                            secondaryButton: .cancel(Text("No"))
                        )
                    }

                        Button("Save") {
                            store.saveProfile()
                            syncHandoff()
                            showingSaveConfirmation = true
                        }
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .alert(isPresented: $showingSaveConfirmation) {
                            Alert(
                                title: Text("Profile Saved"),
                                message: Text("Your information has been saved successfully."),
                                dismissButton: .default(Text("OK")) {
                                    navigationManager.push(.homeview)
                                }
                            )
                        }
                    }
                    .padding(.top)
                    
                    // MARK: - Button structure
                    
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
                    .padding(.bottom)
                }
                .padding(.horizontal)
                .background(Color.white)
            }
        }
        private func syncHandoff() {
            let activity = NSUserActivity(activityType: "com.adrian.expenditure.profile")
            store.updateUserActivity(activity)
    }

    }
        
    
    extension NumberFormatter {
        static var currency: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            return formatter
        }
    }

