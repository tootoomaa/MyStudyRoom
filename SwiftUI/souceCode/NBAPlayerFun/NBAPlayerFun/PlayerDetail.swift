//
//  ContentView.swift
//  NBAPlayerFun
//
//  Created by 김광수 on 2021/01/29.
//

import SwiftUI

struct PlayerDetail: View {
    
    var player: Player
    
    init(player : Player) {
        self.player = player
    }
    
    var body: some View {
        
        VStack {
            Image(player.team.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Image(player.imageName)
                .clipShape(Circle())
                .background(Circle())
                .foregroundColor(.white)
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .offset(x: 0, y: -90)
                .padding(.bottom, -90)
                .shadow(radius: 15)

            Text(player.name)
                .font(.system(size: 70))
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal, 10.0)
                .minimumScaleFactor(0.5)
            
            StatText(statName: "Age", statValue: "\(player.age)")
            StatText(statName: "Height", statValue: "\(player.height)")
            StatText(statName: "Weight", statValue: "\(player.weight)lbs")
            Spacer()
            
        }.edgesIgnoringSafeArea(.top)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetail(player: players[0])
        PlayerDetail(player: players[0]).previewDevice("iPhone SE (2nd generation)")
//        PlayerDetail(player: players[0]).previewDevice("iPhone 8 Plus")
//        PlayerDetail(player: players[0]).previewDevice("iPhone 12 Pro Max")
        
    }
}
