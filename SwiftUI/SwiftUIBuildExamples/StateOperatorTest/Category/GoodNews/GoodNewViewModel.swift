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
    
    private func getGoodNews() {
        
        let goodNewUrl = URL.getGoodNewsArticleURL()
        
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
            .replaceError(with: ArticleResponse(articles: []))
            .assign(to: \.articleList, on: self)
    }
    
}
