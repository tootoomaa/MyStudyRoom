//
//  WeatherResult.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/10/16.
//

import Foundation

struct WeatherResult: Decodable {
  let main: Weather
}

extension WeatherResult {
  
  static var empty: WeatherResult {
    return WeatherResult(main: Weather(temp: 0, humidity: 0))
  }
  
}

struct  Weather: Decodable {
  let temp: Double
  let humidity: Double
}
