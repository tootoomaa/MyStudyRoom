//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by 김광수 on 2020/10/18.
//

import Foundation
import UIKit

class OrdersTableViewController: UITableViewController {
  
  var orderListViewModel = OrderListViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populateOrders()
  }
  
  private func populateOrders() {
    
    WebService().load(resource: Order.all) { [ weak self ] result in
      switch result {
      case .success(let orders):
        self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
        self?.tableView.reloadData()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.orderListViewModel.ordersViewModel.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
    
    cell.textLabel?.text = vm.type
    cell.detailTextLabel?.text = vm.size
    
    return cell
    
  }
  
}
