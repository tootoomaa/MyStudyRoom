//
//  RecipeRatingView.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/24.
//

import SwiftUI

struct RecipeRatingView: View {
    // MARK: - Properties
    var recipe: Recipe
    
    var body: some View {
        //retes
        HStack {
            ForEach(1...(recipe.rating), id: \.self) {  _ in
                Image(systemName: "star.fill")
                    .font(.body)
                    .foregroundColor(Color.yellow)
            }
        }
    }
}

struct RecipeRatingView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRatingView(recipe: recipesData[0])
            .previewLayout(.fixed(width: 320, height: 60))
    }
}
