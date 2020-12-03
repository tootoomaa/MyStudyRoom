//
//  MockSignupViewDelegate.swift
//  PhotoAppTests
//
//  Created by 김광수 on 2020/12/03.
//

import Foundation
import XCTest
@testable import PhotoApp

class MockSignupViewDelegate: SignupViewDelegateProtocol {

    var expectation: XCTestExpectation?
    var successfulSignupCounter = 0
    
    var errorHandlercounter = 0
    var signupError: SignupError?
    
    func successfulSignup() {
        successfulSignupCounter += 1
        expectation?.fulfill()
    }
    
    func errrorHandler(error: SignupError) {
        signupError = error
        errorHandlercounter += 1
        expectation?.fulfill()
    }
}
