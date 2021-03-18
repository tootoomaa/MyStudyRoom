//
//  ContentView.swift
//  BitPriceMac
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
                .font(.largeTitle)
                .padding(20)
        }
        .frame(minWidth: 300, idealWidth: 300, maxWidth: .infinity, minHeight: 300, idealHeight: 300, maxHeight: .infinity, alignment: .center)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
