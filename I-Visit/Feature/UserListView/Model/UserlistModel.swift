//
//  UserlistModel.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 10/12/24.
//


// MARK: - UserListModel
struct UserListModel: Codable {
    var data: [UserList]?
    let total, page, limit: Int?
}

// MARK: - UserList
struct UserList: Codable,Hashable {
    let id: String?
    let title: Title?
    let firstName, lastName: String?
    let picture: String?
}

enum Title: String, Codable {
    case miss = "miss"
    case mr = "mr"
    case mrs = "mrs"
    case ms = "ms"
}
