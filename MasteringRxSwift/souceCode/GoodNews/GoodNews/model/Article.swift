//
//  Article.swift
//  GoodNews
//
//  Created by 김광수 on 2020/10/15.
//

import Foundation

struct ArticlesList: Decodable {
  let articles: [Article]
}

extension ArticlesList {
  
  static var all: Resource<ArticlesList> = {
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=aab00f244cdd43558a60ae6c73002474")!
    return Resource(url: url)
  }()
  
}

struct Article: Decodable {
  let title: String
  let description: String?
}
