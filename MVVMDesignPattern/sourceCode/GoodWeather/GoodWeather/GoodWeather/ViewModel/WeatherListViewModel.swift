//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/13.
//

import Foundation

// MARK: - WeatherListViewModel
class WeatherListViewModel {
  // set ReadOnly(set)
  private(set) var weatherViewModels = [WeatherViewModel]()
  
}

extension WeatherListViewModel {
  
  
  func addWeatherViewModel(vm: WeatherViewModel) {
    self.weatherViewModels.append(vm)
  }
  
  func numberOfRows(_ section: Int) -> Int {
    return self.weatherViewModels.count
  }
  
  func modelAt(_ index: Int) -> WeatherViewModel {
    return self.weatherViewModels[index]
  }
  
  private func toCelsius() {
    
    weatherViewModels = weatherViewModels.map { vm in
      
      let weatherViewModel = vm
      weatherViewModel.currentTemperature.temperature.value =
        (weatherViewModel.currentTemperature.temperature.value - 32) * 5/9
      return weatherViewModel
      
    }
    
  }

  private func toFahrenheit() {
    
    weatherViewModels = weatherViewModels.map { vm in
      
      let weatherViewModel = vm
      weatherViewModel.currentTemperature.temperature.value =
        (weatherViewModel.currentTemperature.temperature.value * 9/5 ) + 32
      return weatherViewModel
      
    }
  }
  
  func updateUnit(to unit: Unit) {
    
    switch unit {
    case .celsius:
      toCelsius()
    case .fahrenheit:
      toFahrenheit()
    }
    
  }
}

// MARK: - Binding for Dynamic
class Dynamic<T>: Decodable where T: Decodable {
  
  typealias Listener = (T) -> ()
  var listener: Listener?
  
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  func bind(listener: @escaping Listener) {
    self.listener = listener
    self.listener?(self.value)
  }
  
  init(_ value: T) {
    self.value = value
  }
  
  private enum CodingKeys: CodingKey {
    case value
  }
}

// MARK: - WeatherViewModel
struct WeatherViewModel: Decodable {
  
  let name : Dynamic<String>
  var currentTemperature: TemperatureViewModel
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = Dynamic(try container.decode(String.self, forKey: .name))
    currentTemperature = try container.decode(TemperatureViewModel.self, forKey: .currentTemperature)
  }
  
  enum CodingKeys: String, CodingKey {
    case name
    case currentTemperature = "main"
  }
}

struct TemperatureViewModel: Decodable {
  
  var temperature: Dynamic<Double>
  let temperatureMin: Dynamic<Double>
  let temperatureMax: Dynamic<Double>
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CordingKeys.self)
    
    temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
    temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
    temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
    
  }
  
  enum CordingKeys: String, CodingKey {
    case temperature = "temp"
    case temperatureMin = "temp_min"
    case temperatureMax = "temp_max"
  }
}
