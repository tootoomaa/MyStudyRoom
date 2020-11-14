//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/14.
//

import Foundation

enum Unit: String, CaseIterable {
  case celsius = "metric"
  case fahrenheit = "imperial"
}

extension Unit {
  
  var displayName: String {
    get {
      switch(self) {
      case .celsius:
        return "Celsius"
      case .fahrenheit:
        return "Fahrenheit"
      }
    }
  }
  
}

struct SettingsViewModel {
  
  let units = Unit.allCases //[Unit.celsius, Unit.fahrenheit]
  
  
}
