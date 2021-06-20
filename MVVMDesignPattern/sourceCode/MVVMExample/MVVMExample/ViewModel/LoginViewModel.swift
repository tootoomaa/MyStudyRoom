//
//  LoginViewModel.swift
//  MVVMExample
//
//  Created by 김광수 on 2021/05/11.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel: ViewModelType, ObservableObject {
    // MARK: - Properties
    var dependency: Dependency
    var input: Input
    var output: Output
    var cancelable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    struct Dependency { } // 의존성 주입 - Ex) Network API, DataManager...
    
    class Input: ObservableObject {
        @Published var email: String = ""
        @Published var password: String = ""
    }
    
    class Output: ObservableObject {
        @Published var isDisable: Bool = false
    }
    
    var user: User {
        return User(email: input.email, password: input.password)
    }
    
    // MARK: - Init
    required init(dependency: Dependency = Dependency()) {
        
        self.input = Input()
        self.output = Output()
        self.dependency = dependency
        
        // MARK: - Data Stream
        Publishers.CombineLatest(input.$email, input.$password)
            .map{ $0.isEmpty || $1.isEmpty }
            .sink { self.output.isDisable = $0 }
            .store(in: &cancelable)
    }
}
