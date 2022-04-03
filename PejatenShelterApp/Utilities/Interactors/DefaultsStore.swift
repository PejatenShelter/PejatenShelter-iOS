//
//  DefaultsStore.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 23/04/22.
//

import Foundation

protocol DefaultsStore {
    func loginWith(_ user: UserModel)
    func isUserLoggedIn() -> Bool
}

final class DefaultsStoreImpl: DefaultsStore {
    func loginWith(_ user: UserModel) {
        UserDefaults.userLogin = true
        UserDefaults.userId = user.uid
        UserDefaults.userEmail = user.email
    }
    
    func isUserLoggedIn() -> Bool {
        return UserDefaults.userLogin
    }
}
