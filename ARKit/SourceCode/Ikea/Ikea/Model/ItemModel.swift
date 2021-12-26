//
//  ItemModel.swift
//  Ikea
//
//  Created by 김광수 on 2021/12/11.
//

import Foundation

struct Item: Identifiable {
    let id: UUID = UUID()
    let title: String
    
    var sceneItem: String {
        "Models.scnassets/\(title)/\(title).scn"
    }
}

