//
//  Webservice.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/13.
//

import Foundation

enum NetworkError: Error {
  case failToGetURL
  case failToGetData
  case failToConnectServer
  case failToDecoding
}

struct Resource<T> {
  let url: URL
  let parse: (Data) -> T?
}

final class Webservice {
  
  func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
    
    URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
      
      if let data = data {
        // tableView가 변경되도록 해야하기 떄문
        print(data)
        
        DispatchQueue.main.async {
          completion(resource.parse(data))
        }
        
      } else {
        completion(nil)
      }
      
    }.resume()
  }
  
}
