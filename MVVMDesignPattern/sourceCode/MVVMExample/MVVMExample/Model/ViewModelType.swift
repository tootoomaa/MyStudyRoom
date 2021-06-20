//
//  ViewModelType.swift
//  MVVMExample
//
//  Created by 김광수 on 2021/05/12.
//

import Foundation
import Combine

protocol ViewModelType {
    associatedtype Dependency
    associatedtype Input
    associatedtype Output
    
    var dependency: Dependency { get }
    var cancelable: Set<AnyCancellable> { get set }
    
    var input: Input { get }
    var output: Output { get }
    
    init(dependency: Dependency)
}

