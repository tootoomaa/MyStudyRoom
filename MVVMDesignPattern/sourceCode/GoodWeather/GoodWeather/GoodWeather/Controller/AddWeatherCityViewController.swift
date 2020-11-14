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
  
  var delegate: AddWeatherDelegate?
  
  @IBOutlet weak var cityNameTextField: UITextField!
  
  @IBAction func saveCityButtonPressed() {
    
    guard let city = cityNameTextField.text else { return }
    
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a312f4e6a3bd2a9b460d3a7075990340&units=imperial")!
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if let error = error {
        print("Error", error.localizedDescription)
        return
      }
      
      guard let httpRespnse = response as? HTTPURLResponse,
            (200..<300).contains(httpRespnse.statusCode) else {
        print("Worng Response")
        return
      }
      
      guard let data = data else {
        print("Fail to get Data")
        return
      }
      
      if let weatherData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] {
        if let name = weatherData["name"] as? String {
          
          if let main = weatherData["main"] as? [String: Any] {
            
            guard let temp = main["temp"] as? Double,
                  let minTemp = main["temp_min"] as? Double,
                  let maxTemp = main["temp_max"] as? Double else { return }
            
            let temperatureVM = TemperatureViewModel(temperature: temp,
                                                     temperatureMin: minTemp,
                                                     temperatureMax: maxTemp)
            
            let vm = WeatherViewModel(name: name, currentTemperature: temperatureVM)
            
            DispatchQueue.main.async {
              self.delegate?.addWeatherDidSave(vm: vm)
              self.dismiss(animated: true, completion: nil)
            }
          }
        }
      }
      
      if let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data) {
        DispatchQueue.main.async {
          self.delegate?.addWeatherDidSave(vm: weatherVM)
        }
      }
      
    }.resume()
    
//    let weatherResource = Resource<WeatherViewModel>(url: url) { data in
//
//      let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
//
//      return weatherVM
//
//    }
//
//    Webservice().load(resource: weatherResource) { [weak self] result in
//
//      if let weatherVM = result {
//        if let delegate = self?.delegate {
//          delegate.addWeatherDidSave(vm: weatherVM)
//          self?.dismiss(animated: true, completion: nil)
//        } else {
//          fatalError(" Fail to get Delegate")
//        }
//
//      } else {
//        fatalError("Fail to get VM")
//      }
//
//    }
    
    
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
