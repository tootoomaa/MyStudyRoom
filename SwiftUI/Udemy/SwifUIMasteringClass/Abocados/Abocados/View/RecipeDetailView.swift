//
//  RecipeDetailView.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/24.
//

import SwiftUI

struct RecipeDetailView: View {
    // MARK: - Properties
    var recipe: Recipe
    
    @State private var pulsate: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                //Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFit()
                Group {
                    //Title
                    Text(recipe.title)
                        .font(.system(.largeTitle, design: .serif))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("ColorGreenAdaptive"))
                        .padding(.top, 10)
                    // Rating
                    RecipeRatingView(recipe: recipe)
                    
                    // Cooking
                    RecipeCookingView(recipe: recipe)
                    
                    // ingredient
                    Text("Ingredients")
                        .fontWeight(.bold)
                        .modifier(TitleModifier())
                    
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(recipe.ingredients, id: \.self) { item in
                            Text(item)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                            Divider()
                        }
                    } //: VSTACK
                    // instructions
                    Text("Instruction")
                        .fontWeight(.bold)
                        .modifier(TitleModifier())
                    
                    ForEach(recipe.instructions, id: \.self) { item in
                        VStack(alignment: .center, spacing: 10) {
                            
                            Image(systemName: "chevron.down.circle")
                                .resizable()
                                .frame(width: 42, height: 42, alignment: .center)
                                .imageScale(.large)
                                .font(Font.title.weight(.ultraLight))
                                .foregroundColor(Color.green)
                                .padding(.bottom, 5)
                            
                            Text(item)
                                .lineLimit(nil)
                                .multilineTextAlignment(.center)
                                .font(.system(.body, design: .serif))
                        }
                    } //: ForEach
                    
                } //: Group
                .padding(.horizontal, 24)
                .padding(.horizontal, 12)
            } //: VSTACK
        } //: ScrollView
        .edgesIgnoringSafeArea(.top)
        .overlay(
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.title)
                            .foregroundColor(Color.pink)
                            .shadow(radius: 4)
                            .opacity(self.pulsate ? 1 : 0.6)
                            .scaleEffect(self.pulsate ? 1.2 : 0.8)
                            .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true))
                    })
                    .padding(.trailing, 20)
                    .padding(.top, 24)
                    Spacer()
                } //: VSTACK
            } //: HSTACK
        ) //: Overlay
        .onAppear {
            self.pulsate.toggle()
        }
    }
}

// MARK: - Preview
struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: recipesData[0])
    }
}
