//
//  AddOrderViewConroller.swift
//  HotCoffee
//
//  Created by 김광수 on 2020/10/18.
//

import Foundation
import UIKit

protocol AddCoffeeOrderDelegate {
  func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController)
  func addCoffeeOrderViewControllerDidClose(controller: UIViewController)
}


class AddOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var delegate: AddCoffeeOrderDelegate?
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  private var coffeeSizeSegmentedControll: UISegmentedControl!
  
  private var vm = AddCoffeeOrderViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
//    self.tableView.delegate = self
//    self.tableView.dataSource =  self
  }
  
  private func setupUI() {
    
    self.coffeeSizeSegmentedControll = UISegmentedControl(items: self.vm.sizes)
    self.coffeeSizeSegmentedControll.translatesAutoresizingMaskIntoConstraints = false
    self.coffeeSizeSegmentedControll.selectedSegmentIndex = 0
    
    self.view.addSubview(coffeeSizeSegmentedControll)
    NSLayoutConstraint.activate([
      self.coffeeSizeSegmentedControll.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
      self.coffeeSizeSegmentedControll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
    ])
    
  }
  
  // MARK: - UITableView
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    tableView.cellForRow(at: indexPath)?.accessoryType = .none
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.vm.types.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
    
    cell.textLabel?.text = self.vm.types[indexPath.row]
    
    return cell
  }
  
  // MARK: - Button Action
  @IBAction func tapCloseButton() {
    
    if let delegate = self.delegate {
      delegate.addCoffeeOrderViewControllerDidClose(controller: self)
    }
    
  }
  
  @IBAction func tapSaveButton() {
    guard let name = self.firstNameTextField.text else { return }
    guard let email = self.lastNameTextField.text else { return }
    
    guard let selectedSize = self.coffeeSizeSegmentedControll.titleForSegment(at: self.coffeeSizeSegmentedControll.selectedSegmentIndex) else { return }
    
    guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
    
    self.vm.name = name
    self.vm.email = email
    
    self.vm.selectedType = self.vm.types[indexPath.row]
    self.vm.selectedSize = selectedSize
    
    print(self.vm)
    
    WebService().load(resource: Order.create(vm: self.vm)) { result in
      switch result {
      case .success(let order):
        
        if let order = order, let delegate = self.delegate {
          DispatchQueue.main.async {
            delegate.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
          }
        }
        
      case .failure(let error):
        print("Error", error.localizedDescription)
      }
    }
    
  }
}
