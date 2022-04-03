//
//  AuthProviding.swift
//  PejatenShelterApp
//
//  Created by Joanda Febrian on 23/04/22.
//

import Foundation

protocol AuthProviding {
    func login(with loginInfo: LoginInfo) async throws -> UserModel?
}
