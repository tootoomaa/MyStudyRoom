//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/13.
//

import Foundation
import UIKit

class AddWeatherCityViewController: UIViewController {
  
  var tempData: Weather?
  
  @IBOutlet weak var cityNameTextField: UITextField!
  
  @IBAction func saveCityButtonPressed() {
    
    guard let city = cityNameTextField.text else { return }
    
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a312f4e6a3bd2a9b460d3a7075990340")!
    
    let weatherResource = Resource<Weather>.init(url: url) { data in
      if let decodeWeather = try? JSONDecoder().decode(Weather.self, from: data) {
        return decodeWeather
      } else {
        return nil
      }
    }
    
    Webservice().load(resource: weatherResource) { [weak self] result in
      print(result)
      self?.tempData = result
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationVC = segue.destination as? WeatherListTableViewController,
          let weatherDate = tempData else { return }
    destinationVC.weatherViewModel.myWeatherList.append(weatherDate)
    destinationVC.tableView.reloadData()
  }
}
