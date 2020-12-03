//
//  SignupViewDelegateProtocol.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/12/03.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    func successfulSignup()
    func errrorHandler(error: SignupError)
}
