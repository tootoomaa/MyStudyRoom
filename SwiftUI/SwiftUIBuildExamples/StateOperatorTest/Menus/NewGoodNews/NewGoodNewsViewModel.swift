//
//  NewGoodNewsViewModel.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/07.
//

import SwiftUI
import Combine

class NewGoodNewsViewModel: ObservableObject {
    
    let articleURL = URL.getGoodNewsArticleURL()
    
    @Published var articleList: ArticleResponse = ArticleResponse(articles: [])
    @Published var isAnimating: Bool = true
    
    var cancelBag = Set<AnyCancellable>()
    
    init() {
        fetchArticleList()
    }
    
    func fetchArticleList() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) { [unowned self] in
            URLSession.shared.dataTaskPublisher(for: articleURL)
                .filter{ (data, response) -> Bool in
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
    }
    
    func fetchArticlePublisher() -> AnyPublisher<ArticleResponse, Never> {
        return URLSession.shared.dataTaskPublisher(for: articleURL)
            .filter{ (data, response) -> Bool in
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
    }
}
