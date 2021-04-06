//
//  GoodNewViewModel.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/02.
//

import Foundation
import SwiftUI
import Combine

class GoodNewViewModel: ObservableObject {
    
    @EnvironmentObject var provider: ServiceProvider
    @Published var articleList: ArticleResponse = ArticleResponse(articles: [])
    
    var cancelBag = Set<AnyCancellable>()
    
    let goodNewUrl = URL.getGoodNewsArticleURL()
    
    init() {
        getGoodNews()
        //        provider.newsService.getGoodNews()
        //            .filter { (data, response) -> Bool in
        //                guard let r = response as? HTTPURLResponse,
        //                      200..<300 ~= r.statusCode else {
        //                    return false
        //                }
        //                return true
        //            }
        //            .map(\.data)
        //            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
        //            .replaceError(with: ArticleResponse.init(articles: []))
        //            .assign(to: \.articleList, on: self)
        //            .store(in: &cancelBag)
    }
    
    private func getGoodNews(completion: @escaping ((Result<ArticleResponse,NetworkError>)-> Void)) {
        
        URLSession.shared.dataTask(with: goodNewUrl) { data, response, error in
            
            guard let r = response as? HTTPURLResponse,
                  200..<300 ~= r.statusCode else {
                return completion(.failure(.responseErro))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let decodeData = try JSONDecoder().decode(ArticleResponse.self, from: data)
                completion(.success(decodeData))
            } catch {
                completion(.failure(.decodeFail))
            }
            
        }.resume()
    }
    
    func getGoodNews() {
        
        return URLSession.shared.dataTaskPublisher(for: goodNewUrl)
            .filter { (data, response) -> Bool in
                guard let r = response as? HTTPURLResponse,
                      200..<300 ~= r.statusCode else {
                    return false
                }
                return true
            }
            .map(\.data)
            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
            .replaceError(with: ArticleResponse(articles: []))
            .assign(to: \.articleList, on: self)
            .store(in: &cancelBag)
    }
    
    func getGoodNewsReturnPublisher() -> AnyPublisher<ArticleResponse, Never> {
        
        return URLSession.shared.dataTaskPublisher(for: goodNewUrl)
            .filter { (data, response) -> Bool in
                guard let r = response as? HTTPURLResponse,
                      200..<300 ~= r.statusCode else {
                    return false
                }
                return true
            }
            .map(\.data)
            .decode(type: ArticleResponse.self, decoder: JSONDecoder())
            .replaceError(with: ArticleResponse(articles: []))
            .eraseToAnyPublisher()
//            .assign(to: \.articleList, on: self)
//            .store(in: &cancelBag)
    }
    
}
