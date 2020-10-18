//
//  WebServices.swift
//  GoodNews
//
//  Created by 김광수 on 2020/10/18.
//

import Foundation

class WebServices {
  
  func getArticles(url: URL, completion: @escaping (([Article]?) -> ()) ) {
    
    URLSession.shared.dataTask(with: url) { data, respone, error in
      
      if let error = error {
      
        print(error.localizedDescription)
        completion(nil)
      
      } else if let data = data {
         
        if let articleList = try? JSONDecoder().decode(ArticlesList.self, from: data) {
          completion(articleList.articles)
        }
        
      }
    }.resume()
  }
}
