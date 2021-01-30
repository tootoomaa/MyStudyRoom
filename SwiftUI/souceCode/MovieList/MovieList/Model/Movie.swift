//
//  Movie.swift
//
//
//  Created by 김광수 on 2021/01/30.
//

import Foundation

struct Movie: Identifiable {
    var id = UUID()
    var title = "Hello"
    var rating = 3.0
    var seen = false
}

class MovieStorage: ObservableObject {
    @Published var movies: [Movie] = []
}
