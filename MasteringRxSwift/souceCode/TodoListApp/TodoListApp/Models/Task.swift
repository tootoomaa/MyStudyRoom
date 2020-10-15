//
//  TaskModel.swift
//  TodoListApp
//
//  Created by 김광수 on 2020/10/15.
//

import Foundation

enum Priority: Int {
  case high
  case medium
  case low
}

struct Task {
  
  var title: String?
  var priority: Priority?
  
  init(title:String, priority: Priority) {
    self.title = title
    self.priority = priority
  }
}
