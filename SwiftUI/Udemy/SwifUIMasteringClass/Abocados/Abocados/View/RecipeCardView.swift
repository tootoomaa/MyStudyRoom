//
//  RecipeCardView.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/24.
//

import SwiftUI

struct RecipeCardView: View {
    // MARK: - Properties
    
    var recipe: Recipe
    var hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    @State private var showModel: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // card Image
            Image(recipe.image)
                .resizable()
                .scaledToFit()
                .overlay(
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "bookmark")
                                .font(Font.title.weight(.light))
                                .foregroundColor(Color.white)
                                .imageScale(.small)
                                .shadow(color: Color("ColorBlackTransparentLight"), radius: 2, x: 0, y: 0)
                                .padding(.trailing, 20)
                                .padding(.top, 20)
                            Spacer()
                        } //: VSTACK
                    } //:HSTACK
                ) //: OVERLAY
            
            VStack(alignment: .leading, spacing: 12, content: {
                // title
                Text(recipe.title)
                    .font(.system(.title, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenMedium"))
                //headline
                Text(recipe.headline)
                    .font(.system(.body, design: .serif))
                    .foregroundColor(Color.gray)
                    .italic()
                
                //retes
                RecipeRatingView(recipe: recipe)
                
                //cooking
                RecipeCookingView(recipe: recipe)
            })
            .padding()
            .padding(.bottom, 12)
        } //: VSTACK
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x: 0, y: 0)
        .onTapGesture {
            self.hapticImpact.impactOccurred()
            self.showModel = true
        }
        .sheet(isPresented: $showModel, content: {
            RecipeDetailView(recipe: self.recipe)
        })
    }
}

// MARK: - PreView
struct RecipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCardView(recipe: recipesData[0])
            .previewLayout(.sizeThatFits)
    }
}
