//
//  TaskTableViewCell.swift
//  MyRxTodoApp
//
//  Created by 김광수 on 2020/12/19.
//

import Foundation
import UIKit

class TaskTableViewCell: UITableViewCell {
  
  static let identifier = "TaskTableViewCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    accessoryType = .checkmark
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
