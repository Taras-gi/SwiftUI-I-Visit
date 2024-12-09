//
//  APIConstant.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 09/12/24.
//

let baseUrl  = "https://reqres.in/"
let baseUrl1 = "https://dummyapi.io/data/v1/"

enum HTTPMeathod:String {
    case get  = "GET"
    case post = "POST"
}

enum ApiType:String {
    case login    = "api/login"
    case userList = "user?"
}
