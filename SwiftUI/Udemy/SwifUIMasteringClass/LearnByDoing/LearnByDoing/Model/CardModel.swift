//
//  CardModel.swift
//  LearnByDoing
//
//  Created by 김광수 on 2021/04/22.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var imageName: String
    var callToAction: String
    var message: String
    var gradientColors: [Color]
}
