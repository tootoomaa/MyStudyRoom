//
//  PlayerList.swift
//  NBAPlayerFun
//
//  Created by 김광수 on 2021/01/29.
//

import SwiftUI

struct PlayerList: View {
    var body: some View {
        
        NavigationView {
            List(players) {
                currentPlayer in
                
                NavigationLink(destination: PlayerDetail(player: currentPlayer)) {
                    PlayerRow(player: currentPlayer)
                        .frame(height: 70)
                        .minimumScaleFactor(0.6)
                }
                
            }.navigationTitle(Text("NBA Finals Player"))
        }
    }
}

struct PlayerList_Previews: PreviewProvider {
    static var previews: some View {
//        PlayerList().previewDevice("iPhone SE (2nd generation)")
//        PlayerList().previewDevice("iPhone 8")
        PlayerList().previewDevice("iPhone 12 Mini")
    }
}
