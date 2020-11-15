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
    
    self.cityNameLabel.text = weatherVM?.name
    self.currentTemperatureLabel.text = weatherVM?.currentTemperature.temperature.formatAsDegree
    
  }
  
  
}
