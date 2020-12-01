//
//  SignupConstants.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/11/29.
//

import Foundation

struct SignupConstants {
    static let firstNameMinLength = 2
    static let firstNameMaxLength = 10
    
    static let lastNameMinLength = 4
    static let lastNameMaxLength = 10
    
    static let passwordMinLength = 8
    static let passwordMaxLength = 16
    
    static let signupRequestURL = "http://appsdeveloperblog.com:8080/signup-mock-service/users"
}
