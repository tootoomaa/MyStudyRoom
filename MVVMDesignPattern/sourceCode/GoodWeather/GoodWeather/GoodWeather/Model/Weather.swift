//
//  Weather.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/13.
//

import Foundation

struct WeatherResult: Decodable {
  let main: Weather
}

struct  Weather: Decodable {
  let name: String
  let temperature: Double
  let temperatureMin: Double
  let temperatureMax: Double
}
