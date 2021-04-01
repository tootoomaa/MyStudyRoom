//
//  GoodNewService.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import Foundation
import SwiftUI
import Combine

protocol GoodNewsServiceType {
    var articleList: ArticleResponse { get }
    func getGoodNews()
    func getGoodNewsByNomal(completion: @escaping (Result<ArticleResponse, NetworkError>) -> ())
}

class GoodNewsService: BaseService, GoodNewsServiceType {
    
    let goodNewUrl = URL.getGoodNewsArticleURL()
    
    var cancelBag = Set<AnyCancellable>()
    
    @Published var articleList = ArticleResponse(articles: [])
    
    func getGoodNewsByNomal(completion: @escaping (Result<ArticleResponse, NetworkError>) -> ()) {
        
        URLSession.shared.dataTask(with: goodNewUrl) { data, response, error in
            
            guard let r = response as? HTTPURLResponse,
                  200..<300 ~= r.statusCode else {
                return completion(.failure(.responseErro))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            if let decodeData = try? JSONDecoder().decode(ArticleResponse.self, from: data) {
                
                print(decodeData)
                return completion(.success(decodeData))
            }
            
            return completion(.failure(.decodeFail))
            
        }.resume()
        
    }
    
    func getGoodNews() { // -> Result<[Article], NetworkError>
        
        URLSession.shared.dataTaskPublisher(for: goodNewUrl)
            .filter { (data, response) -> Bool in
                guard let r = response as? HTTPURLResponse,
                      200..<300 ~= r.statusCode else {
                    return false
                }
                return true
            }
            .map(\.data)
            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
            .replaceError(with: ArticleResponse.init(articles: []))
            .assign(to: \.articleList, on: self)
            .store(in: &cancelBag)
    }
}
