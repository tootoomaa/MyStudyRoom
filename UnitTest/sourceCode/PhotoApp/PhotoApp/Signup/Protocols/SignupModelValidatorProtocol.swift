//
//  SignupModelValidatorProtocol.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/12/02.
//

import Foundation

protocol SignupModelValidatorProtocol {
    func isFirstNameValid(firstName: String) -> Bool
    func isLastNameValid(lastName: String) -> Bool
    func isEmailValid(email: String) -> Bool
    func isPasswordValid(passwd: String) -> Bool
    func doPasswordMatch(password: String, repeatPassword: String) -> Bool
}
