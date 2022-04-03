//
//  LoginViewModelTest.swift
//  PejatenShelterAppTests
//
//  Created by Joanda Febrian on 03/04/22.
//

import XCTest
import FirebaseAuth
@testable import Pejaten_Shelter

class LoginViewModelTest: XCTestCase {
//    func testLoginWithIncompleteDetails() async {
//        func test(username: String?,
//                  password: String?,
//                  expectedError: AuthError,
//                  line: UInt = #line) async {
//            let sut = LoginViewModel(authProvider: AuthProviderMock())
//            var thrownError: Error?
//
//            do {
//                try await sut.login(username: username,
//                                    password: password) {}
//            } catch {
//                thrownError = error
//            }
//
//            XCTAssertNotNil(thrownError)
//            XCTAssertTrue(thrownError is AuthError, line: line)
//            XCTAssertEqual(thrownError as? AuthError, expectedError, line: line)
//        }
//
//        await test(username: nil, password: "password",
//                   expectedError: .incomplete(Set([.username])))
//        await test(username: "", password: "password",
//                   expectedError: .incomplete(Set([.username])))
//        await test(username: "1234567890", password: nil,
//                   expectedError: .incomplete(Set([.password])))
//        await test(username: "1234567890", password: nil,
//                   expectedError: .incomplete(Set([.password])))
//        await test(username: nil, password: nil,
//                   expectedError: .incomplete(Set([.username, .password])))
//        await test(username: "", password: nil,
//                   expectedError: .incomplete(Set([.username, .password])))
//        await test(username: nil, password: "",
//                   expectedError: .incomplete(Set([.username, .password])))
//        await test(username: "", password: "",
//                   expectedError: .incomplete(Set([.username, .password])))
//    }
//
//    func testLoginWithCompleteDetails() async {
//        let authSpy = AuthProviderMock()
//        var errorThrown = false
//        var completionCalled = 0
//        let sut = LoginViewModel(authProvider: authSpy)
//
//        let username = "0123456789"
//        let password = "any-password"
//        guard let expectedInfo = try? LoginInfo(username: username,
//                                                password: password) else {
//            XCTFail("Something's wrong with LoginInfo")
//            return
//        }
//
//        do {
//            try await sut.login(username: username,
//                                password: password) {
//                completionCalled += 1
//            }
//        } catch {
//            errorThrown = true
//        }
//
//        XCTAssertFalse(errorThrown)
//        XCTAssertEqual(authSpy.receivedInfo, expectedInfo)
//        XCTAssertEqual(completionCalled, 1)
//    }
}

final class AuthProviderMock: AuthProviding {
    private(set) var receivedInfo: LoginInfo?
    func login(with loginInfo: LoginInfo) async throws -> UserModel? {
        receivedInfo = loginInfo
        return nil
    }
}
