//
//  ContentView.swift
//  HelloCoreData
//
//  Created by 김광수 on 2022/08/29.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM: CoreDataManager
    @State private var movieName: String = ""
    @State private var movies: [Movie] = [Movie]()
    @State private var needRefresh: Bool = false
    
    private func populateMoviews() {
//        movies = coreDM.getAllMovies()
        movies = coreDM.fetchAllCoreData()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter movie name", text: $movieName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save") {
//                    coreDM.saveMovie(title: movieName)
                    coreDM.addCoreData(data: Movie())
                    populateMoviews()
                }
                
                List {
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink {
                            MovieDetail(
                                movie: movie,
                                coreDM: coreDM,
                                needRefresh: $needRefresh
                            )
                        } label: {
                            Text(movie.title ?? "")
                        }
                    }.onDelete { indexSet in
                        indexSet.forEach { index in
                            let movie = movies[index]
                            coreDM.deleteModel(movie: movie)
                            populateMoviews()
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .accentColor(needRefresh ? .white : .black)
                
                Spacer()
            }
            .padding()
            .onAppear(perform: { populateMoviews() })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
