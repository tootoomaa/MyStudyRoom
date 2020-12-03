//
//  MockSignupModelValidator.swift
//  PhotoAppTests
//
//  Created by 김광수 on 2020/12/02.
//

import Foundation
@testable import PhotoApp

class MockSignupModelValidator: SignupModelValidatorProtocol {
    
    var isFirstNameValidated: Bool = false
    var isLastNameValidated: Bool = false
    var isEmailValidated: Bool = false
    var isPasswordValid: Bool = false
    var isRepeatPasswordValid: Bool = false
    
    func isFirstNameValid(firstName: String) -> Bool {
        isFirstNameValidated = true
        return isFirstNameValidated
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        isLastNameValidated = true
        return isLastNameValidated
    }
    
    func isEmailValid(email: String) -> Bool {
        isEmailValidated = true
        return isEmailValidated
    }
    
    func isPasswordValid(passwd: String) -> Bool {
        isPasswordValid = true
        return isPasswordValid
    }
    
    func doPasswordMatch(password: String, repeatPassword: String) -> Bool {
        isRepeatPasswordValid = true
        return isRepeatPasswordValid
    }
    
}
