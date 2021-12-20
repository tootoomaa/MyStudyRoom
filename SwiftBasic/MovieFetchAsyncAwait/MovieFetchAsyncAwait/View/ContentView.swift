//
//  ContentView.swift
//  MovieFetchAsyncAwait
//
//  Created by 김광수 on 2021/12/18.
//

import SwiftUI

struct ContentView: View {
    
    @State var search: String = ""
    @State var moviesList: [Movie] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $search,
                          onEditingChanged: { _ in },
                          onCommit: {
                    Task {
                        do {
                            self.moviesList = try await WebService().getMoviesBy(search: search)
                        } catch {
                            print(error)
                        }
                    }
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(moviesList, id: \.imdbId) { movie in
                    MovieCell(movie: movie)
                } //: List
                .listStyle(PlainListStyle())
                
            } //: VStack
            .navigationTitle("Movies")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
