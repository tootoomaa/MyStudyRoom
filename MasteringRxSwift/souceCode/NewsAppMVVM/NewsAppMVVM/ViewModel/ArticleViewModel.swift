//
//  ArticleViewModel.swift
//  NewsAppMVVM
//
//  Created by 김광수 on 2020/10/17.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
  
  let articlesVM: [ArticleViewModel]
  
}

extension ArticleListViewModel {
  
  init(_ articles: [Article]) {
    self.articlesVM = articles.compactMap(ArticleViewModel.init)
  }
  
}

extension ArticleListViewModel {
  
  func articleAt(_ index: Int) -> ArticleViewModel {
    return self.articlesVM[index]
  }
  
}

struct ArticleViewModel {
  
  let article: Article
  
  init(_ article: Article) {
    self.article = article
  }
  
}

extension ArticleViewModel {
  
  var title: Observable<String> {
    return Observable<String>.just(article.title)
  }
  
  var description: Observable<String> {
    return Observable<String>.just(article.description ?? "")
  }
  
}
