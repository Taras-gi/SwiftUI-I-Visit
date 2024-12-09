//
//  LoginModel.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 09/12/24.
//

import UIKit

struct LoginModel: Codable {
    var email, password, id, createdAt: String?
}

struct LoginRequestModel: Codable {
    var email, password:String
    
    func loginRequestData() -> Data? {
        do{
            let data = try JSONEncoder().encode(self)
            return data
        }catch{
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
