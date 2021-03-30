//
//  PocketMon.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/29.
//

import SwiftUI

struct Pocketmon {
    
    let id: Int
    let name: String
    let type: String
    let color: Color
    
    init(id: Int, name: String, type: String, color: Color) {
        self.id = id
        self.name = name
        self.type = type
        self.color = color
    }
}
