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
    func getGoodNews() -> URLSession.DataTaskPublisher
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
    
    func getGoodNews() -> URLSession.DataTaskPublisher { // -> Result<[Article], NetworkError>
        return URLSession.shared.dataTaskPublisher(for: goodNewUrl)
    }
}
