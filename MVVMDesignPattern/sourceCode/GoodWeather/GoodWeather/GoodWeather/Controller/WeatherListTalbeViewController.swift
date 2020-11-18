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
  private var dataSource: WeatherDataSource?
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.dataSource = WeatherDataSource(weatherListVM)
    self.tableView.dataSource = self.dataSource
    
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
    
    if segue.identifier == "AddWeatherCityVC" {
      
      prepareSegueForAddWeatherCityVC(segue: segue)
      
    } else if segue.identifier == "SettingTableViewVC" {

      prepareSegueForSettingsTableVC(segue: segue)
      
    } else if segue.identifier == "WeatherDetailVC" {
      
      prepareSegueForWeatherDetailVC(segue: segue)
      
    }
  }
  
  // MARK: - AddWeatherCityViewController
  private func prepareSegueForAddWeatherCityVC(segue: UIStoryboardSegue) {
    
    guard let nav = segue.destination as? UINavigationController else {
      fatalError("NavigationContoller not found")
    }
    
    guard let addWeatherVC = nav.viewControllers.first as? AddWeatherCityViewController else {
      fatalError("AddWeatherVC not Fount")
    }
    
    addWeatherVC.delegate = self
  }
  
  func addWeatherDidSave(vm: WeatherViewModel) {
    
    weatherListVM.addWeatherViewModel(vm: vm)
    tableView.reloadData()
  }
  
  // MARK: - SettingsTableViewController
  private func prepareSegueForSettingsTableVC(segue: UIStoryboardSegue) {
    
    guard let nav = segue.destination as? UINavigationController else {
      fatalError("NavigationContoller not found")
    }
    
    guard let settingsTableVC = nav.viewControllers.first as? SettingsTableViewController else {
      fatalError("SettingsTableViewController not Fount")
    }
    
    settingsTableVC.delegate = self
  }
  
  
  private func prepareSegueForWeatherDetailVC(segue: UIStoryboardSegue) {
    
    guard let weatherDetailVC = segue.destination as? WeatherDetailViewController,
          let indexPath = self.tableView.indexPathForSelectedRow else {
      return
    }
    
    weatherDetailVC.weatherVM = weatherListVM.modelAt(indexPath.row)
  }
  
  // MARK: - UITableView
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}

extension WeatherListTableViewController: SettingsDelegate {
  
  func settingsDone(vm: SettingsViewModel) {
    
    self.weatherListVM.updateUnit(to: vm.selectedUnit)
    self.tableView.reloadData()
    
  }
  
}
