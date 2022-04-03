//
//  FirebaseAuthTest.swift
//  PejatenShelterAppIntegrationTests
//
//  Created by Joanda Febrian on 15/04/22.
//

import XCTest
import FirebaseAuth
@testable import Pejaten_Shelter

class FirebaseAuthTest: XCTestCase {
//    func testLoginWithValidAccount() async {
//        let sut = FirebaseAuth()
//        var receivedUser: UserModel?
//        let expectation = expectation(description: "Login successfully with valid account")
//        
//        do {
//            let validAccount = try LoginInfo(username: "admin",
//                                             password: "qwertyuiop")
//            receivedUser = try await sut.login(with: validAccount)
//            expectation.fulfill()
//        } catch {
//            XCTFail("error thrown: \(error)")
//        }
//        
//        await waitForExpectations(timeout: 2)
//        XCTAssertNotNil(receivedUser)
//        XCTAssertEqual(receivedUser?.email, "admin@pejatenshelter.com")
//    }
//    
//    func testLoginWithInvalidAccount() async {
//        let sut = FirebaseAuth()
//        var receivedUser: UserModel?
//        var errorThrown = false
//        let expectation = expectation(description: "Login failed")
//        
//        do {
//            let validAccount = try LoginInfo(username: "invalid",
//                                             password: "asdfghjkl")
//            receivedUser = try await sut.login(with: validAccount)
//            XCTFail("Login success with invalid account")
//        } catch {
//            errorThrown = true
//            expectation.fulfill()
//        }
//        
//        await waitForExpectations(timeout: 2)
//        XCTAssertTrue(errorThrown)
//        XCTAssertNil(receivedUser)
//    }
}
