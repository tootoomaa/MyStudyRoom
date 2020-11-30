//
//  SignupFormRequestModel.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/11/30.
//

import Foundation

class SignupFormRequestModel: Encodable {
    
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
    init(firstName: String, lastName: String, email: String, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
    
}
