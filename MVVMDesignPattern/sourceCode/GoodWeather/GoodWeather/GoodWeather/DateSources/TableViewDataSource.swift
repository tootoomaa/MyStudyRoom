//
//  TableViewDataSource.swift
//  GoodWeather
//
//  Created by 김광수 on 2020/11/18.
//

import Foundation
import UIKit

class TableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
  
  typealias configureCellType = (CellType, ViewModel) -> ()
  
  let cellIdentifier: String
  var items: [ViewModel]
  let configureCell: configureCellType
  
  init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping configureCellType) {
    self.cellIdentifier = cellIdentifier
    self.items = items
    self.configureCell = configureCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellType else {
      fatalError("Fail to get \(self.cellIdentifier)")
    }
    
    let vm = self.items[indexPath.row]
    self.configureCell(cell, vm)
    
    return cell
  }
  
  func updateItems(_ items: [ViewModel]) {
    self.items = items
  }
}
