//
//  WeatherDataSource.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/18.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
  
  let cellIdentifier: String
  private var weatherListVM: WeatherListViewModel
  
  init(_ weatherListVM: WeatherListViewModel) {
    self.cellIdentifier = "WeatherCell"
    self.weatherListVM = weatherListVM
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.weatherListVM.weatherViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WeatherCell else {
      fatalError("Fail to get \(cellIdentifier)")
    }
    
    let weatherVM = self.weatherListVM.modelAt(indexPath.row)
    
    weatherVM.name.bind { cell.cityNameLabel.text = $0 }
    weatherVM.currentTemperature.temperature.bind {
      cell.temparatureLabel.text = $0.formatAsDegree
    }
    
    return cell
  }
  
}
