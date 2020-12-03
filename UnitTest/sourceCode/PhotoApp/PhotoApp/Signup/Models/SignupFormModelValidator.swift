//
//  SignupFormModelValidator.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/11/29.
//

import Foundation

class SignupFormModelValidator: SignupModelValidatorProtocol {
    
    func isFirstNameValid(firstName: String) -> Bool {
        var returnValue = true
        
        if firstName.count < SignupConstants.firstNameMinLength ||
            firstName.count > SignupConstants.firstNameMaxLength {
            returnValue = false
        }
        
        return returnValue
    }
    
    func isLastNameValid(lastName: String) -> Bool {
        var returnValue = true
        
        if lastName.count < SignupConstants.lastNameMinLength ||
            lastName.count > SignupConstants.lastNameMaxLength {
            returnValue = false
        }
            
        return returnValue
    }
    
    
    func isEmailValid(email: String) -> Bool {
        var returnValue = true
        
        if !email.contains("@") || !email.contains(".") {
            returnValue = false
        }
        
        return returnValue
    }
    
    func isPasswordValid(passwd: String) -> Bool {
        var returnValue = true
        
        if passwd.count < SignupConstants.passwordMinLength ||
            passwd.count > SignupConstants.passwordMaxLength {
            
            returnValue = false
            
        }
        
        return returnValue
    }
    
    func doPasswordMatch(password: String, repeatPassword: String) -> Bool {
        
        return password == repeatPassword
        
    }
    
}
