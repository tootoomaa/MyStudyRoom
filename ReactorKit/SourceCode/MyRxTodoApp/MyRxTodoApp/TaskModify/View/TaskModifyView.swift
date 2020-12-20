//
//  TaskModifyView.swift
//  MyRxTodoApp
//
//  Created by 김광수 on 2020/12/20.
//

import Foundation
import UIKit
import Then
import SnapKit

class TaskModifyView: UIView {
  
  let taskTextField = UITextField().then {
    $0.placeholder = "Do Something.."
    $0.layer.borderWidth = 1
    $0.layer.cornerRadius = 5
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    configureLayout()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout() {
    
    [taskTextField].forEach {
      addSubview($0)
    }
    
    taskTextField.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
      $0.leading.equalTo(safeAreaLayoutGuide).offset(20)
      $0.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
      $0.height.equalTo(50)
    }
    
  }
  
}
