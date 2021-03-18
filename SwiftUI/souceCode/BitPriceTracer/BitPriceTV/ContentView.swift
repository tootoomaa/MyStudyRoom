//
//  ContentView.swift
//  BitPriceTV
//
//  Created by 김광수 on 2021/01/31.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dataStorage = BitData()
    
    var body: some View {
        VStack {
            Image("btc")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(40)
            Text(dataStorage.btcPrice)
                .font(.system(size: 200))
                .padding(.bottom, 30)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
