//
//  UserDetailModel.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 10/12/24.
//

import Foundation

// MARK: - UserDetailModel
struct UserDetailModel: Codable {
    let id, title, firstName, lastName: String?
    let picture: String?
    let gender, email, dateOfBirth, phone: String?
    let location: Location?
    let registerDate, updatedDate: String?
}

// MARK: - Location
struct Location: Codable {
    let street, city, state, country: String?
    let timezone: String?
}


