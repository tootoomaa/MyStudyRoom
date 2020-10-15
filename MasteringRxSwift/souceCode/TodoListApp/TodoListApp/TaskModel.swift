//
//  TaskModel.swift
//  TodoListApp
//
//  Created by 김광수 on 2020/10/15.
//

import Foundation

class TeskModel {
  
  var title: String?
  var type: String?
  
  init(title:String, type: String) {
    self.title = title
    self.type = type
  }
}
