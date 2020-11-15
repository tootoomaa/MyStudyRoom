//
//  SettingsTableViewController.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/14.
//

import Foundation
import UIKit

protocol SettingsDelegate {
  func settingsDone(vm: SettingsViewModel)
}

class SettingsTableViewController: UITableViewController {
  // MARK: - Properties
  var delegate: SettingsDelegate?
  
  private var settingsVM = SettingsViewModel()
  
  // MARK: - Life Cycle
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
  
  @IBAction func close() {
    
    if let delegate = delegate {
      delegate.settingsDone(vm: self.settingsVM)
    }
    
    self.dismiss(animated: true, completion: nil)
    
  }
  
  // MARK: - TableView
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.settingsVM.units.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let settingsItem = self.settingsVM.units[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
    
    cell.textLabel?.text = settingsItem.displayName
    
    if settingsItem == settingsVM.selectedUnit {
      cell.accessoryType = .checkmark
      cell.isSelected = true
    }
    
    return cell
    
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //unchecked All checkMark
    tableView.visibleCells.forEach {
      $0.accessoryType = .none
    }
    
    if let cell = tableView.cellForRow(at: indexPath) {
      cell.accessoryType = .checkmark
      
      let unit = Unit.allCases[indexPath.row]
      self.settingsVM.selectedUnit = unit
      
    }
    
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    
    if let cell = tableView.cellForRow(at: indexPath) {
      cell.accessoryType = .none
    }
    
  }
  
}
