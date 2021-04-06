//
//  UserManager.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import Foundation

protocol UserServiceType {
    func login()
    func logout()
    func signin()
    func signout()
    func exit()
}

class UserServcie: BaseService, UserServiceType {
    func login() {
        print(#function)
    }
    
    func logout() {
        print(#function)
    }
    
    func signin() {
        print(#function)
    }
    
    func signout() {
        print(#function)
    }
    
    func exit() {
        print(#function)
    }
}
