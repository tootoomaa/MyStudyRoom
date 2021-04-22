//
//  ContentView.swift
//  LearnByDoing
//
//  Created by 김광수 on 2021/04/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 20) {
                ForEach(cardData) { card in
                    CardView(card: card)
                }
            }
        }
        .padding(20)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone Pro 11")
    }
}
