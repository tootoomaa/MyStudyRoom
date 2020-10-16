//
//  URL+Extension.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/10/16.
//

import Foundation

extension URL {
  static func urlForWeatherAPI(city: String) -> URL? {
    return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a312f4e6a3bd2a9b460d3a7075990340")!
  }
}



