//
//  DisplayNumber.swift
//  CleanArchitectureExample
//
//  Created by 김광수 on 2021/06/06.
//

import Foundation

class DisplayNumber: ObservableObject, Equatable {
    @Published var number: Int = 0
    
    static func == (lhs: DisplayNumber, rhs: DisplayNumber) -> Bool {
        lhs.number == rhs.number
    }
}
