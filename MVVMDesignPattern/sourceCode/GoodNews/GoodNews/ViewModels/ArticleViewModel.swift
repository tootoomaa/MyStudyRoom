//
//  ArticleViewModel.swift
//  GoodNews
//
//  Created by 김광수 on 2020/10/18.
//

import Foundation

// For Search bar or Need to change all things
struct ArticleListViewModel {
  let articles: [Article]
}

extension ArticleListViewModel {
  
  var numberOfSection: Int {
    return 1
  }
  
  func numberOfRowInSection(_ section: Int) -> Int {
    return self.articles.count
  }
  
  func articleAtIndex(_ index: Int) -> ArticleViewModel {
    let article = articles[index]
    return ArticleViewModel(article)
  }
  
}


struct ArticleViewModel {
  private let article: Article
}

extension ArticleViewModel {
  init(_ article: Article) {
    self.article = article
  }
}

extension ArticleViewModel {
  
  var title: String {
    return self.article.title
  }
  
  var description: String? {
    return self.article.description ?? ""
  }
  
}
