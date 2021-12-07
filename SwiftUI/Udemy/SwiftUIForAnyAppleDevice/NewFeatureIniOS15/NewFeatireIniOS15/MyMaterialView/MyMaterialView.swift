//
//  MyMaterialView.swift
//  AysncImageTestApp
//
//  Created by 김광수 on 2021/12/04.
//

import SwiftUI

struct MyMaterialView: View {
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: "https://m.media-amazon.com/images/M/MV5BYThjYzcyYzItNTVjNy00NDk0LTgwMWQtYjMwNmNlNWJhMzMyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")!)
            
            HStack {
                Text("Movie")
            }
            .frame(maxWidth: .infinity, minHeight: 300)
//            .background(.ultraThinMaterial)                   // 블러뷰
            .background(.ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: 10))
            
        }.padding()
    }
}

struct MyMaterialView_Previews: PreviewProvider {
    static var previews: some View {
        MyMaterialView()
    }
}
