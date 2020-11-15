//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/13.
//

import Foundation


struct WeatherListViewModel {
  
  private var weatherViewModels = [WeatherViewModel]()
  
  mutating func addWeatherViewModel(vm: WeatherViewModel) {
    self.weatherViewModels.append(vm)
  }
  
  func numberOfRows(_ section: Int) -> Int {
    return self.weatherViewModels.count
  }
  
  func modelAt(_ index: Int) -> WeatherViewModel {
    return self.weatherViewModels[index]
  }
  
  private mutating func toCelsius() {
    
    weatherViewModels = weatherViewModels.map { vm in
      
      var weatherViewModel = vm
      weatherViewModel.currentTemperature.temperature =
          (weatherViewModel.currentTemperature.temperature - 32) * 5/9
      return weatherViewModel
      
    }
    
  }

  private mutating func toFahrenheit() {
    
    weatherViewModels = weatherViewModels.map { vm in
      
      var weatherViewModel = vm
      weatherViewModel.currentTemperature.temperature =
          (weatherViewModel.currentTemperature.temperature * 9/5 ) + 32
      return weatherViewModel
      
    }
  }
  
  mutating func updateUnit(to unit: Unit) {
    
    switch unit {
    case .celsius:
      toCelsius()
    case .fahrenheit:
      toFahrenheit()
    }
    
  }
}

struct WeatherViewModel: Decodable {
  
  let name : String
  var currentTemperature: TemperatureViewModel
  
  enum CodingKeys: String, CodingKey {
    case name
    case currentTemperature = "main"
  }
}

struct TemperatureViewModel: Decodable {
  
  var temperature: Double
  let temperatureMin: Double
  let temperatureMax: Double
  
  enum CordingKeys: String, CodingKey {
    case temperature = "temp"
    case temperatureMin = "temp_min"
    case temperatureMax = "temp_max"
  }
}
