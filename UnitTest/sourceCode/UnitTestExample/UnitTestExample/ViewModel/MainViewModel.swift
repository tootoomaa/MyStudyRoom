//
//  MainViewModel.swift
//  UnitTestExample
//
//  Created by 김광수 on 2021/05/08.
//

import Foundation
import Combine

protocol ViewModelType {
    associatedtype Dependency
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
    var dependency: Dependency { get }
    
    init(dependency: Dependency)
}

class MainViewModel: ViewModelType {
    
    var input: Input
    var output: Output
    var dependency: Dependency
    
    struct Input {
//        var name: String = ""
//        var password: String = ""
    }
    
    struct Output {
//        var isLoginBtEnable: Bool {
//            return !(self.dependency.name.isEmpty && self.dependency.password.isEmpty)
//        }
    }
    
    struct Dependency {
        var name: String?
        var password: String?
    }
    
    
    required init(dependency: Dependency = Dependency(name: nil, password: nil)) {
        self.dependency = dependency
        
        self.input = Input(name: <#T##String#>, password: <#T##String#>)
    }
    
}


