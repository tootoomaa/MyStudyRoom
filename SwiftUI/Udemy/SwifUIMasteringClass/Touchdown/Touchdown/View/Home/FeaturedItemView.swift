//
//  FeaturedItemView.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

struct FeaturedItemView: View {
    // MARK: - Properties
    let player: Player
    
    // MARK: - Body
    var body: some View {
        Image(player.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

// MARK: - Preview
struct FeaturedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItemView(player: players[0])
            .previewLayout(.sizeThatFits)
            .padding()
            .background(colorBackgroud)
    }
}
