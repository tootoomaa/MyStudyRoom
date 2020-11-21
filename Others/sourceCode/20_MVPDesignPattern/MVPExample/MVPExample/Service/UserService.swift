//
//  UserService.swift
//  MVPExample
//
//  Created by 김광수 on 2020/11/21.
//

import Foundation

class UserService {
  
  func getUsers(completion: @escaping ([User]) -> Void) {
    
    let users = [ User(uid: "1", name: "Kim", age: 15, number: "111-1111-1111", country: "Korea"),
                  User(uid: "2", name: "Park", age: 20, number: "111-1111-1111", country: "Korea"),
                  User(uid: "3", name: "Lee", age: 25, number: "111-1111-1111", country: "Korea")]
    
    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
      completion(users)
    }
  }
  
}
