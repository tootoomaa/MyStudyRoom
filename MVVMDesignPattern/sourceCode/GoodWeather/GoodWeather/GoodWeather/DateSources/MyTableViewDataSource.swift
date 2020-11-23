//
//  MyTableViewDataSource.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/23.
//

import Foundation
import UIKit

class MyTableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
  
  let identifier: String
  let items: [ViewModel]
  let configureCell: (CellType, ViewModel) -> ()
  
  init(_ idenfitier: String, _ cell: CellType, _ items: [ViewModel], configureCell: @escaping (CellType,ViewModel) -> () ) {
    self.identifier = idenfitier
    self.items = items
    
    self.configureCell = configureCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CellType else { fatalError("Can't find CellType") }
    
    let vm = self.items[indexPath.row]
    self.configureCell(cell, vm)
    
    return cell
  }
}
