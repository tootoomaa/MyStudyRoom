//
//  DataProvider.swift
//  MyRxTodoApp
//
//  Created by 김광수 on 2020/12/19.
//

import Foundation

enum ProviderType {
  case taskProvider
}

protocol DataProviderType {
  
}

class DataProvider {
  typealias ProviderType
  
  let provider: ProviderType
  
  init(_ provider: ProviderType) {
    self.provider = provider
  }
  
}
