//
//  UserDataManager.swift
//  ThirdRoc
//
//  Created by Smt MacMini 3 on 04/03/24.
//

import Foundation

final class UserDataManager {

    let defaults = UserDefaults.standard
    static let shared = UserDataManager()

    var token: String? {
        get {
            if let token = defaults.object(forKey: "apptoken") as? String {
                return token
            }
            return nil
        }
        set {
            defaults.set(newValue, forKey: "apptoken")
        }
    }
    
    var homeScreen:Bool? {
        get {
            if let data = defaults.object(forKey: "appTabbar") as? Bool {
                return data
            }
            return nil
        }
        set{
            defaults.set(newValue, forKey: "appTabbar")
        }
    }
}
