//
//  ContentView.swift
//  StocksApp
//
//  Created by 김광수 on 2021/12/04.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var stockListVM = StockListViewModel()
    
    var body: some View {
        List(stockListVM.stocks, id: \.name) { stock in
            HStack {
                Text(stock.name)
                Spacer()
                Text(stock.price.formatted(.currency(code: "USD")))
            }
        }
        .task           { stockListVM.getAllStocks() }
        .refreshable    { stockListVM.getAllStocks() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
