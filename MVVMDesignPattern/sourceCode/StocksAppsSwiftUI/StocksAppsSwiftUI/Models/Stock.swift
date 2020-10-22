//
//  Stock.swift
//  StocksAppsSwiftUI
//
//  Created by 김광수 on 2020/10/19.
//

import Foundation

struct Stock: Decodable {
  
  let symbol: String
  let description: String
  let price: Double
  let change: String
  
}
