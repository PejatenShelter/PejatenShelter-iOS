//
//  UserDefaults+User.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 23/04/22.
//

import Foundation

extension UserDefaults {
    public enum Keys {
        static let userLogin = "userLogin"
        static let userId = "userId"
        static let userEmail = "userEmail"
    }
    
    @Defaults(key: UserDefaults.Keys.userLogin, defaultValue: false)
    static var userLogin: Bool
    
    @Defaults(key: UserDefaults.Keys.userId, defaultValue: "")
    static var userId: String
    
    @Defaults(key: UserDefaults.Keys.userEmail, defaultValue: "")
    static var userEmail: String
}
