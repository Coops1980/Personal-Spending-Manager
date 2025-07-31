//
//  UserProfile.swift
//  Expense Tracker
//
//  Created by Adrian Cooper on 08/07/2025.
//
import Foundation

struct UserProfile: Codable {
    var title: String
    var firstName: String
    var lastName: String
    var email: String
    var telephoneNumber: String
    var mobileNumber: String
    var employeeNumber: String
    var misc: String
    var monthlyBudget: Double?              //Sets the amount for personal spending calcs
}
