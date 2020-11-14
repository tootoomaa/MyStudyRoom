//
//  WeatherListTalbeViewController.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/13.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController, AddWeatherDelegate {
  // MARK: - Properties
  private var weatherListVM = WeatherListViewModel()
  
  // MARK: - Life cycle
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
  
  func addWeatherDidSave(vm: WeatherViewModel) {
    
    weatherListVM.addWeatherViewModel(vm: vm)
    tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "AddWeatherCityVC" {
      
      prepareSegueForAddWeatherCityVC(segue: segue)
      
    } else if segue.identifier == "SettingTableViewVC" {

      prepareSegueForSettingsTableVC(segue: segue)
      
    }
  }
  
  private func prepareSegueForAddWeatherCityVC(segue: UIStoryboardSegue) {
    
    guard let nav = segue.destination as? UINavigationController else {
      fatalError("NavigationContoller not found")
    }
    
    guard let addWeatherVC = nav.viewControllers.first as? AddWeatherCityViewController else {
      fatalError("AddWeatherVC not Fount")
    }
    
    addWeatherVC.delegate = self
  }
  
  private func prepareSegueForSettingsTableVC(segue: UIStoryboardSegue) {
    
  }
  
  // MARK: - UITableView
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return weatherListVM.numberOfRows(section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
    
    let weatherVM = self.weatherListVM.modelAt(indexPath.row)
    
    cell.cityNameLabel.text = weatherVM.name
    cell.temparatureLabel.text = weatherVM.currentTemperature.temperature.formatAsDegree
    
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
