//
//  ContentView.swift
//  Moview Tracker
//
//  Created by 김광수 on 2021/01/30.
//

import SwiftUI

struct MoviewDetail: View {
    /*
     - Understandable
     - Interactrable
     - Nacigable
     
     */
    
    @State var movie: Movie
    @EnvironmentObject var movieStorage: MovieStorage
    @Environment(\.presentationMode) var presentationMode
    let newMovie: Bool
    
    var body: some View {
        
        List {
            Section {
                SectionTitle(title: "Title")
                TextField("Movie Title", text: $movie.title)
            }
            
            Section {
                SectionTitle(title: "Rating")
                HStack {
                    Spacer()
                    Text(String(repeating: "⭑", count: Int(movie.rating)))
                        .foregroundColor(.yellow)
                        .font(.title)
                        .accessibility(label: Text("\(Int(movie.rating)) Star Rating"))
                    Spacer()
                    
                }
                Slider(value: $movie.rating, in: 1...5, step: 1)
                    .accessibility(label: Text("\(Int(movie.rating)) star Rating Slider"))
            }
            
            Section {
                SectionTitle(title: "Seen")
                Toggle(isOn: $movie.seen, label: {
                    if movie.title == "" {
                        Text("Has Seen this Movie")
                    } else {
                        Text("I have seen \(movie.title)")
                    }
                })
            }
            
            Section {
                HStack {
                    Spacer()
                    Button(action: {
                        if self.newMovie {
                            self.movieStorage.movies.append(movie)
                        } else {
                            for x in 0..<self.movieStorage.movies.count {
                                if self.movieStorage.movies[x].id == movie.id {
                                    self.movieStorage.movies[x] = movie
                                }
                            }
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }.disabled(movie.title.isEmpty)
                    Spacer()
                }
            }
        }.listStyle(GroupedListStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        MoviewDetail(movie: Movie(), newMovie: true)
    }
}

struct SectionTitle: View {
    var title = ""
    var body: some View {
        Text(title)
            .font(.caption)
            .foregroundColor(.blue)
    }
}
