//
//  AppState.swift
//  CleanArchitectureExample
//
//  Created by 김광수 on 2021/06/06.
//

import Foundation

class AppState: ObservableObject {

    @Published var displayNumder = DisplayNumber()
//    @Published var routing = ViewRouting()
//    @Published var system = System()
}

extension AppState: Equatable {
    
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        lhs.displayNumder.number == rhs.displayNumder.number
    }
    
}
