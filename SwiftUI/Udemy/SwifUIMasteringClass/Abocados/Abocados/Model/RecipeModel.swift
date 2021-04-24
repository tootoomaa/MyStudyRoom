//
//  RecipeModel.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/24.
//

import Foundation

// MARK: - Recipe Model

struct Recipe: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var rating: Int
    var serves: Int
    var preparation: Int
    var cooking: Int
    var instructions: [String]
    var ingredients: [String]
}


/*
 title: "Avocado Crostini",
 headline: "Colourful twist on a classic.",
 image: "avocado-crostini",
 rating: 5,
 serves: 4,
 preparation: 20,
 cooking: 0,
 instructions: [
 */
