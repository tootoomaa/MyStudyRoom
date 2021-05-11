//
//  LoginViewModel.swift
//  MVVMExample
//
//  Created by 김광수 on 2021/05/11.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    
    var cancellable = Set<AnyCancellable>()
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isDisable: Bool = false
    
    var user: User {
        return User(email: email, password: password)
    }
    
    init() {
        
        Publishers.CombineLatest($email, $password)
            .map{ $0.isEmpty || $1.isEmpty }
            .sink { self.isDisable = $0 }
            .store(in: &cancellable)
        
    }
    
}
