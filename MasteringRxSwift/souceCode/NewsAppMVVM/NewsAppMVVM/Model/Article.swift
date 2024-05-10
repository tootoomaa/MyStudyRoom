//
//  Article.swift
//  NewsAppMVVM
//
//  Created by 김광수 on 2020/10/17.
//

import Foundation

struct ArticleResponse: Codable {
  let articles: [Article]
}

struct Article: Decodable {
  let title: String
  let description: String?
}

