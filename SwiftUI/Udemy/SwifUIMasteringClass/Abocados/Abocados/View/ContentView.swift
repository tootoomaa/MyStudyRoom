//
//  ContentView.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    var headers: [Header] = headersData
    var recipes: [Recipe] = recipesData
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20, content: {
                
                // MARK: - Heaser
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach (headers) { item in
                            HeaderView(header: item)
                        }
                    }
                }
                
                // MARK: - DISHES
                Text("Avocado Dishes")
                    .fontWeight(.bold)
                    .modifier(TitleModifier())
                
                DishesView()
                
                // MARK: - Avocado Fact
                Text("Avocado Facts")
                    .fontWeight(.bold)
                    .modifier(TitleModifier())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 60) {
                        ForEach(factsData) { item in
                            FactsView(fact: item)
                        }
                    }
                    .padding(.horizontal, 60)
                }
                
                // MARK: - Recipes Card
                Text("Avocado Recipes")
                    .fontWeight(.bold)
                    .modifier(TitleModifier())
                
                VStack(alignment: .center, spacing: 20, content: {
                    ForEach(recipes) { recipe in
                        RecipeCardView(recipe: recipe)
                    }
                })
                .frame(maxWidth: 640)
                .padding(.horizontal )
                
                // MARK: - Footer
                Text("All abount Avocados")
                    .modifier(TitleModifier())
                Text("asdjflkadsfjalskfjaklsf")
                    .font(.system(.body, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }) //: VSTACK
        } //: SCROLLVIEW
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .serif))
            .foregroundColor(Color("ColorGreenAdaptive"))
            .padding(8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
