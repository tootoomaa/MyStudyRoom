//
//  HeaderModel.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/24.
//

import Foundation

// MARK: - Header Model

struct Header: Identifiable {
    var id = UUID()
    var image: String
    var headline: String
    var subheadline: String
}
