//
//  RecipeCookingview.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/24.
//

import SwiftUI

struct RecipeCookingView: View {
    // MARK: - Properties
    var recipe: Recipe
    
    var body: some View {
        HStack(alignment: .center, spacing: 12, content: {
            HStack(alignment: .center, spacing: 2, content: {
                Image(systemName: "person.2")
                Text("Serves: \(recipe.serves)")
            })
            HStack(alignment: .center, spacing: 2, content: {
                Image(systemName: "clock")
                Text("Prep: \(recipe.serves)")
            })
            HStack(alignment: .center, spacing: 2, content: {
                Image(systemName: "flame")
                Text("Cooking: \(recipe.serves)")
            })
        })
        .font(.footnote)
        .foregroundColor(Color.gray)
    }
}

struct RecipeCookingview_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCookingView(recipe: recipesData[0])
            .previewLayout(.sizeThatFits)
            .padding()
            
    }
}
