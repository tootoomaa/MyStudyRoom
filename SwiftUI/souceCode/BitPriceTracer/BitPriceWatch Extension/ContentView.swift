//
//  ContentView.swift
//  BitPriceWatch Extension
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
                .padding(10)
            Text(dataStorage.btcPrice)
                .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
