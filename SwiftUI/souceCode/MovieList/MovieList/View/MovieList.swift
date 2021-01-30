//
//  MovieList.swift
//
//
//  Created by 김광수 on 2021/01/30.
//

import SwiftUI

struct MovieList: View {
    
    @EnvironmentObject var movieStorage : MovieStorage
//    @State var pushView = false
    
    var body: some View {
        
        NavigationView {
            List(movieStorage.movies) { currnetMovie in
                
                NavigationLink(destination: MoviewDetail(movie: currnetMovie,
                                                         newMovie: false)) {
                    Text(currnetMovie.title)
                }
                
            }.navigationTitle("My Movie List")
            .navigationBarItems(trailing:
                    
                NavigationLink(destination: MoviewDetail(movie: Movie(),
                                                         newMovie: true)) {
                    Image(systemName: "plus")
                }
            
            )
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}

