//
//  AsyncImageView.swift
//  AysncImageTestApp
//
//  Created by 김광수 on 2021/12/04.
//

import SwiftUI

struct AsyncImageView: View {
    let posterURL = URL(string: "https://m.media-amazon.com/images/M/MV5BYThjYzcyYzItNTVjNy00NDk0LTgwMWQtYjMwNmNlNWJhMzMyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")!
    
    var body: some View {
        AsyncImage(url: posterURL) { phase in
            if let image = phase.image {
                image
            } else if phase.error != nil {
                Image(systemName: "exclamationmark.circle")
            } else {
                Image(systemName: "photo")
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
