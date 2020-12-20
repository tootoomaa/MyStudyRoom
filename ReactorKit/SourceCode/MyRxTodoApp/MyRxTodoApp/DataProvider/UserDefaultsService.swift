//
//  UserDefaultsService.swift
//  MyRxTodoApp
//
//  Created by 김광수 on 2020/12/19.
//

import Foundation
import RxSwift

protocol UserDefaultsServiceType {
  func value() -> Observable<[String]>
  func set(value: [String])
}

final class UserDefaultsService: UserDefaultsServiceType {
  
  private var defaults: UserDefaults {
    return UserDefaults.standard
  }
  
  func value() -> Observable<[String]> {
    let task = self.defaults.value(forKey: "Task") as? [String] ?? []
    return Observable.just(task)
  }
  
  func set(value: [String]) {
    self.defaults.setValue(value, forKey: "Task")
  }
  
}

