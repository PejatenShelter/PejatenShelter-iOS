//
//  LoginInfo.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 11/04/22.
//

import Foundation

enum LoginField: String {
    case username = "Username"
    case password = "Password"
}

struct LoginInfo: Equatable {
    let username: String
    let password: String
    
    init(username: String?, password: String?) throws {
        var emptyFields = Set<LoginField>()
        if username?.isEmpty ?? true  { emptyFields.insert(.username) }
        if password?.isEmpty ?? true { emptyFields.insert(.password) }
        guard let username = username,
              let password = password,
              emptyFields.isEmpty
        else { throw AuthError.incomplete(emptyFields) }
        
        self.username = username
        self.password = password
    }
}
