//
//  WeatherDetailViewController.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/15.
//

import Foundation
import UIKit

class WeatherDetailViewController: UIViewController {
  
  @IBOutlet weak var cityNameLabel: UILabel!
  @IBOutlet weak var currentTemperatureLabel: UILabel!
  @IBOutlet weak var maxTemperatureLabel: UILabel!
  @IBOutlet weak var minTemperatureLabel: UILabel!
  
  var weatherVM: WeatherViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.setupVMBinding()
  }
  
  private func setupVMBinding() {
    
    if let weatherVM = weatherVM {
      
      weatherVM.name.bind { self.cityNameLabel.text = $0 }
      weatherVM.currentTemperature.temperature.bind {
        self.currentTemperatureLabel.text = $0.formatAsDegree
      }
      
      weatherVM.currentTemperature.temperatureMax.bind {
        self.maxTemperatureLabel.text = $0.formatAsDegree
      }
      
      weatherVM.currentTemperature.temperatureMin.bind {
        self.minTemperatureLabel.text = $0.formatAsDegree
      }
      
    }
    
  }
  
}
