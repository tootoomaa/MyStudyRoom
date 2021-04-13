//
//  Constant.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

//class Constant

// DATA

let players: [Player] = Bundle.main.decode("player.json")
let categories: [Category] = Bundle.main.decode("category.json")

// COLOR
let colorBackgroud: Color = Color("ColorBackground")
let colorGray: Color = Color(UIColor.systemGray4)

// LAYOUT

let columnSpacing: CGFloat = 10
let rowSpacing: CGFloat = 10
var gridLayout: [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}

// UX
// API
// IMAGE
// FONT
// STRING
// MISC
