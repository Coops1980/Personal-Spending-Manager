//
//  UserProfileStore.swift
//  Personal Spending Manager
//
//  Created by Adrian Cooper on 28/07/2025.
//


import Foundation

final class UserProfileStore: ObservableObject {
    @Published var profile: UserProfile? {
        didSet {
            saveProfile()
        }
    }

    private let storageKey = "userProfile"

    init() {
        loadProfile()
    }

    func saveProfile() {
        guard let profile = profile else { return }
        do {
            let data = try JSONEncoder().encode(profile)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Error saving user profile: \(error.localizedDescription)")
        }
    }

    func loadProfile() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            profile = try JSONDecoder().decode(UserProfile.self, from: data)
        } catch {
            print("Error loading user profile: \(error.localizedDescription)")
        }
    }

    func clearProfile() {
        UserDefaults.standard.removeObject(forKey: storageKey)
        profile = nil
    }
}
