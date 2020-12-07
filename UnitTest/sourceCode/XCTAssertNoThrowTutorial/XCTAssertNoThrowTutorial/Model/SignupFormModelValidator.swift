//
//  SignupFormValidator.swift
//  XCTAssertNoThrowTutorial
//
//  Created by 김광수 on 2020/12/07.
//

import Foundation

class SignupFormModelValidator {
    
    private let invalidCharacters = CharacterSet(charactersIn: "{}@#$%^&*()_+,.")
    
    func isFirstNameValid(_ firstName: String) throws -> Bool {
        
        var returnValue = true
        
        // Check for illigal character
        if (firstName.rangeOfCharacter(from: invalidCharacters) != nil ) {
            throw SignupError.illigalCharactersFound
        }
        
        // Check first Name
        if firstName.count < 2 || firstName.count > 10 {
            returnValue = false
        }
        
        return returnValue
    }
    
}
