//
//  StockListViewModel.swift
//  StocksApp
//
//  Created by 김광수 on 2021/12/04.
//

import Foundation

@MainActor
class StockListViewModel: ObservableObject {
    
    @Published var stocks: [StockViewModel] = []
    
    func getAllStocks() {
        
        Task {
            let stock = await StockService().getStocks()
            self.stocks = stock.map(StockViewModel.init)
        }
        
    }
    
}

struct StockViewModel {
    
    let stock: Stock
    
    var name: String {
        stock.name
    }
    
    var price: Double {
        stock.price
    }
    
}
