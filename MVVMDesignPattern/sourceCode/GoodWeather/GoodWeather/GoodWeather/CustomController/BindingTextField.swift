//
//  BindingTextField.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/15.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
  
  var textChangeClosure: (String) -> Void = { _ in }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    commoninit()
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commoninit()
  }
  
  func bind(callback: @escaping (String) -> ()) {
    self.textChangeClosure = callback
  }
  
  
  private func commoninit() {
    
    self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    
  }
  
  @objc func textFieldDidChange(_ textField: UITextField) {
    if let text = textField.text {
      self.textChangeClosure(text)
    }
    
  }
  
}
