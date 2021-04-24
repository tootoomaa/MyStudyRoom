//
//  FactModel.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/24.
//

import Foundation

// MARK: - Fact Model

struct Fact: Identifiable {
    var id = UUID()
    var image: String
    var content: String
}
