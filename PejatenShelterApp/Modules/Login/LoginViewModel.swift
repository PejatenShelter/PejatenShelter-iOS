//
//  LoginViewModel.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 03/04/22.
//

import Foundation

final class LoginViewModel {
    private let authProvider: AuthProviding!
    private let defaultsStore: DefaultsStore!
    
    init(authProvider: AuthProviding,
         defaultsStore: DefaultsStore) {
        self.authProvider = authProvider
        self.defaultsStore = defaultsStore
    }
    
    func login(username: String?,
               password: String?,
               completion: @escaping () -> Void) async throws {
        do {
            let loginInfo = try LoginInfo(username: username,
                                          password: password)
            guard let user = try await authProvider.login(with: loginInfo)
            else { throw AuthError.unknown }
            defaultsStore.loginWith(user)
            completion()
        } catch { throw error }
    }
}
