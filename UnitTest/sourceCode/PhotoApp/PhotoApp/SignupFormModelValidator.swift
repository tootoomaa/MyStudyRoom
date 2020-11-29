//
//  SignupFormModelValidator.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/11/29.
//

import Foundation

class SignupFormModelValidator {
    
    func isFirstNameValid(firstName: String) -> Bool {
        var returnValue = true
        
        if firstName.count < SingupConstants.firstNameMinLength ||
            firstName.count > SingupConstants.firstNameMaxLength {
            returnValue = false
        }
        
        return returnValue
    }
    
}
