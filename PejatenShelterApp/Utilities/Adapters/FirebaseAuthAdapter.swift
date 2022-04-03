//
//  FirebaseAuthAdapter.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 11/04/22.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthAdapter: AuthProviding {
    func login(with loginInfo: LoginInfo) async throws -> UserModel? {
        do {
            let authResult = try await Auth.auth().signIn(
                withEmail: loginInfo.username + "@pejatenshelter.com",
                password: loginInfo.password)
            guard let email = authResult.user.email
            else { throw AuthError.unknown }
            return UserModel(uid: authResult.user.uid,
                             email: email)
        } catch {
            guard let errCode = AuthErrorCode(rawValue: error._code) else {
                throw AuthError.unknown
            }
            switch errCode {
            case .networkError:
                throw AuthError.networkError
            case .invalidCredential:
                throw AuthError.invalid
            default:
                throw AuthError.unknown
            }
        }
    }
}
