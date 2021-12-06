//
//  StockService.swift
//  StocksApp
//
//  Created by 김광수 on 2021/12/04.
//

import Foundation

struct Stock {
    let name: String
    let price: Double
}

class StockService {
    
    func getStocks(completion: @escaping ([Stock]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            let stocks: [Stock] = [
                Stock(name: "APPLE", price: Double.random(in: 200...300)),
                Stock(name: "GOOGLE", price: Double.random(in: 1000...2000)),
                Stock(name: "MICROSOFT", price: Double.random(in: 300...500))
            ]
            
            completion(stocks)
        }
    }
    
    // async로 생성된 함수는 비동기 행동이 끝날때 까지 멈춘다.
    func getStocks() async -> [Stock] {
        await withUnsafeContinuation({ continuation in
            getStocks { result in
                continuation.resume(returning: result)
            }
        })
    }
    
}
