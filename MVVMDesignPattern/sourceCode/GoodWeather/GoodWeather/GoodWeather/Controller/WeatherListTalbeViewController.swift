//
//  WeatherListTalbeViewController.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/13.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController {
  
  var weatherViewModel = WeatherViewModel()
  
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
  
  
  // MARK: - UITableView
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherViewModel.myWeatherList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
    
    let weather = weatherViewModel.myWeatherList[indexPath.row]
    
    cell.cityNameLabel.text = weather.name
    cell.temparatureLabel.text = "\(weather.temperature)"
    
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
