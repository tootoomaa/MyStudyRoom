//
//  Article.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable, Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let description: String?
}
