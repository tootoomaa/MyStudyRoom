//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by 김광수 on 2020/10/18.
//

import Foundation
import UIKit

class OrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate {
  
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
  
  func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
    controller.dismiss(animated: true, completion: nil)
    let orderVM = OrderViewModel(order: order)
    self.orderListViewModel.ordersViewModel.append(orderVM)
    self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count-1, section: 0)], with: .automatic)
  }
  
  func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let navC = segue.destination as? UINavigationController,
          let addOrderViewConroller = navC.viewControllers.first as? AddOrderViewController else {
      fatalError("AddOrderViewController Casting Error")
    }
    addOrderViewConroller.delegate = self
  }
  
  // MARK: - About TableView
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