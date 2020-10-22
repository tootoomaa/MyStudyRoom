//
//  StockListViewModel.swift
//  StocksAppsSwiftUI
//
//  Created by 김광수 on 2020/10/19.
//

import Foundation


class StockListViewModel: ObservableObject {
  
  var searchTerm: String = ""
  @Published var stocks: [StockViewModel] = [StockViewModel]() // subscribe 가능

  func laod() {
    fetchStocks()
  }
  
  private func fetchStocks() {
    WebService().getStocks { stocks in
  
      if let stocks = stocks {
        DispatchQueue.main.async {
          self.stocks = stocks.map(StockViewModel.init)
        }
      }
      
    }
  }
  
}
