//
//  Article.swift
//  GoodNews
//
//  Created by 김광수 on 2020/10/18.
//

import Foundation

struct ArticlesList: Decodable {
  let articles: [Article]
}

struct Article: Decodable {
  let title: String
  let description: String?
}
