//
//  ItemModel.swift
//  NewProject
//
//  Created by 김광수 on 2021/08/01.
//

import Foundation

struct Item: Identifiable, Equatable {
    let id: String = UUID().uuidString
    let time: Date
    let string: String
}
