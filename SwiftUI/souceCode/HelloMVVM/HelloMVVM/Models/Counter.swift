//
//  Counter.swift
//  HelloMVVM
//
//  Created by 김광수 on 2021/03/24.
//

import Foundation

struct Counter {
    
    var value: Int = 0
    var isPremeum: Bool = false
    
    mutating func increment() {
        value += 1
        
        if value.isMultiple(of: 3) {
            isPremeum = true
        } else {
            isPremeum = false
        }
    }
    
}
