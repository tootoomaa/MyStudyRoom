//
//  MovieDetail.swift
//  HelloCoreData
//
//  Created by 김광수 on 2022/08/30.
//

import SwiftUI

struct MovieDetail: View {
    
    let movie: Movie
    @State private var movieName: String = ""
    @State private var actorName: String = ""
    let coreDM: CoreDataManager
    @Binding var needRefresh: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            TextField(movie.title ?? "", text: $movieName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Update") {
                movie.title = movieName
                coreDM.updateMovie()
                needRefresh.toggle()
            }
            
            Text("Add Actor")
            TextField("Actor Name", text: $actorName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("add") {
                
                coreDM.updateMovie()
                needRefresh.toggle()
            }
        }.padding()
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        let coreDM = CoreDataManager()
        let movie = Movie(context: coreDM.persistentContainer.viewContext)
        MovieDetail(
            movie: movie,
            coreDM: coreDM,
            needRefresh: .constant(false)
        )
    }
}
