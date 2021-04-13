//
//  FeaturedTabView.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

struct FeaturedTabView: View {
    var body: some View {
        TabView {
            ForEach(players) { item in
                FeaturedItemView(player: item)
                    .padding(.top, 10)
                    .padding(.horizontal, 15)
            } //: Loops
        } //: TabView
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

struct FeaturedTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedTabView()
            .previewDevice("iPhone 12 Pro")
            .background(Color.gray)
    }
}
