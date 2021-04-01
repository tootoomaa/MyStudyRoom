//
//  URL+Extension.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import Foundation

enum NetworkError: Error {
    
    case urlError
    case noData
    case decodeFail
    case responseErro
    
}

extension URL {
    
    static func getGoodNewsArticleURL() -> URL {
        
        let myURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=aab00f244cdd43558a60ae6c73002474")!
        
        return myURL
    }
    
}
