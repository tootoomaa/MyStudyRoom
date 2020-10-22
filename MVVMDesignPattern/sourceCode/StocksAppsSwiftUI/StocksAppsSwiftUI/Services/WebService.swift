//
//  WebService.swift
//  StocksAppsSwiftUI
//
//  Created by 김광수 on 2020/10/19.
//

import Foundation

class WebService {
  
  func getStocks(completion: @escaping (([Stock]?) -> Void)) {
  
    guard let url = URL(string: "https://island-bramble.glitch.me/stocks") else {
      fatalError("Fail To Get URL")
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      
      guard let data = data, error == nil else {
        completion(nil)
        return
      }
      
      let stocks = try? JSONDecoder().decode([Stock].self, from: data)
      stocks == nil ? completion(nil) : completion(stocks)
      
    }.resume()
    
  }
}
