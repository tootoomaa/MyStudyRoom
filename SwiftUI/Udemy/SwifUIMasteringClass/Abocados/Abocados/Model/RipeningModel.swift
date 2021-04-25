//
//  RipeningModel.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/25.
//

import Foundation

// MARK: - Ripening Model

struct Ripening: Identifiable {
    var id = UUID()
    var image: String
    var stage: String
    var title: String
    var description: String
    var ripeness: String
    var instruction: String
}
