//
//  Double+Extension.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/14.
//

import Foundation

extension Double {
 
  var formatAsDegree: String {
    return String(format: "%.0fº", self)
  }
  
}
