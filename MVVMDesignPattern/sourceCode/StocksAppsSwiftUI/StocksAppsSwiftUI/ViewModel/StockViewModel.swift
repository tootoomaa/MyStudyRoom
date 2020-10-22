//
//  StockViewModel.swift
//  StocksAppsSwiftUI
//
//  Created by 김광수 on 2020/10/19.
//

import Foundation

struct StockViewModel {
  
  let stock: Stock
  
  var symbol: String {
    return self.stock.symbol.uppercased()
  }
  
  var description: String {
    return self.stock.description
  }
  
  var price: String {
    return String(format: "%.2f", self.stock.price)
  }
  
  var change: String {
    return self.stock.change
  }
  
}

