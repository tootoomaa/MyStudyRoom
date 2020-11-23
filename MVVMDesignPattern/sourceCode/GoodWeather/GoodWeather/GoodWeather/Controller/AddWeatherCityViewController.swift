//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/13.
//

import Foundation
import UIKit

protocol AddWeatherDelegate {
  func addWeatherDidSave(vm: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
  
  var addCityVM = AddCityViewModel()
  
  var delegate: AddWeatherDelegate?
  
  @IBOutlet weak var cityNameTextField: BindingTextField! {
    didSet {
      cityNameTextField.bind { self.addCityVM.city = $0 }
    }
  }
  
  @IBOutlet weak var stateTextField: BindingTextField! {
    didSet {
      stateTextField.bind { self.addCityVM.state = $0 }
    }
  }
  
  @IBOutlet weak var zipCodeTextFidel: BindingTextField! {
    didSet {
      zipCodeTextFidel.bind { self.addCityVM.zipCode = $0 }
    }
  }
  
  @IBAction func saveCityButtonPressed() {
    
    guard let city = cityNameTextField.text else { return }
    
    let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a312f4e6a3bd2a9b460d3a7075990340&units=imperial")!
    
    let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
      
      let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
      
      return weatherVM
      
    }

    Webservice().load(resource: weatherResource) { [weak self] result in
      
      if let weatherVM = result {
        if let delegate = self?.delegate {
          delegate.addWeatherDidSave(vm: weatherVM)
//          print(weatherVM.currentTemperature.temperature.value)
          self?.dismiss(animated: true, completion: nil)
        } else {
          fatalError(" Fail to get Delegate")
        }

      } else {
        fatalError("Fail to get VM")
      }

    }
    
    
  }
  
  @IBAction func close() {
    
    self.dismiss(animated: true, completion: nil)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavigationController()
  }
  
  private func configureNavigationController() {
    
    let naviBackGroundColor = UIColor(displayP3Red: 47/255, green: 54/255, blue: 64/255, alpha: 1.0)
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = naviBackGroundColor
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }
}
