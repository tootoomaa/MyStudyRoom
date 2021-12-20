//
//  MovieCell.swift
//  MovieFetchAsyncAwait
//
//  Created by 김광수 on 2021/12/18.
//

import SwiftUI

struct MovieCell: View {
    
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top) {
//            URLImage(url: movie.poster)
//                .frame(width: 100, height: 125)
//                .cornerRadius(10)
            Text(movie.title)
        }
    }
}
