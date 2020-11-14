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
}

struct WeatherViewModel: Decodable {
  
  let name : String
  let currentTemperature: TemperatureViewModel
  
  enum CodingKeys: String, CodingKey {
    case name
    case currentTemperature = "main"
  }
}

struct TemperatureViewModel: Decodable {
  
  let temperature: Double
  let temperatureMin: Double
  let temperatureMax: Double
  
  enum CordingKeys: String, CodingKey {
    case temperature = "temp"
    case temperatureMin = "temp_min"
    case temperatureMax = "temp_max"
  }
}
