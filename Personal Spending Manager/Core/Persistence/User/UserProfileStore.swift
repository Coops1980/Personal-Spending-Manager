//
//  UserProfileStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 31/07/2025.
//
import Foundation

class UserProfileStore: ObservableObject {
    @Published var profile: UserProfile

    private let localStorageKey = "userProfile"

    // MARK: - Init
    init() {
        self.profile = UserProfile(
            title: "", firstName: "", lastName: "", email: "",
            telephoneNumber: "", mobileNumber: "", employeeNumber: "",
            misc: "", monthlyBudget: nil
        )

        // Load from local storage asynchronously after initialization
        DispatchQueue.main.async {
            self.profile = self.loadProfileFromLocal(localKey: self.localStorageKey)
        }
    }

    // MARK: - Save
    func saveProfile() {
        do {
            let data = try JSONEncoder().encode(profile)
            UserDefaults.standard.set(data, forKey: localStorageKey)
        } catch {
            print("❌ Error saving profile locally: \(error.localizedDescription)")
        }
    }

    // MARK: - Clear
    func clearProfile() {
        UserDefaults.standard.removeObject(forKey: localStorageKey)

        self.profile = UserProfile(
            title: "", firstName: "", lastName: "", email: "",
            telephoneNumber: "", mobileNumber: "", employeeNumber: "",
            misc: "", monthlyBudget: nil
        )
    }

    // MARK: - Handoff Support
    func updateUserActivity(_ activity: NSUserActivity) {
        activity.title = "Editing User Profile"
        if let encoded = try? JSONEncoder().encode(profile) {
            activity.userInfo = ["profile": encoded]
        }
        activity.isEligibleForHandoff = true
        activity.becomeCurrent()
    }

    // MARK: - Load from Local Storage
    private func loadProfileFromLocal(localKey: String) -> UserProfile {
        guard let localData = UserDefaults.standard.data(forKey: localKey),
              let decoded = try? JSONDecoder().decode(UserProfile.self, from: localData)
        else {
            return UserProfile(
                title: "", firstName: "", lastName: "", email: "",
                telephoneNumber: "", mobileNumber: "", employeeNumber: "",
                misc: "", monthlyBudget: nil
            )
        }

        return decoded
    }
}
