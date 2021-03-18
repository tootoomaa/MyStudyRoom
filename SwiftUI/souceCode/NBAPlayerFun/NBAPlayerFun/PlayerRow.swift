//
//  PlayerRow.swift
//  NBAPlayerFun
//
//  Created by 김광수 on 2021/01/29.
//

import SwiftUI

struct PlayerRow: View {
    
    var player: Player
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            Image(player.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .contentShape(Circle())
                .clipShape(Circle())
                .background(Circle()).foregroundColor(player.team.color)
            
            Text(player.name)
                .font(.system(.largeTitle))
            
            Spacer()
            
        }.minimumScaleFactor(0.6)
    }
}

struct PlayerRow_Previews: PreviewProvider {
    
    static var previews: some View {
        PlayerRow(player: players[0]).previewDevice("iPhone 8")
            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
//        Group {
//
//            PlayerRow(player: players[0]).previewDevice("iPhone 11 Max Pro")
//        }
    }
}
