//
//  AddOrderViewConroller.swift
//  HotCoffee
//
//  Created by 김광수 on 2020/10/18.
//

import Foundation
import UIKit

class AddOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func tapSaveButton() {
    let name = self.firstNameTextField.text
    let email = self.lastNameTextField.text
    
    let selectedSize = self.coffeeSizeSegmentedControll.titleForSegment(at: self.coffeeSizeSegmentedControll.selectedSegmentIndex)
    
    guard let indexPath = self.tableView.indexPathForSelectedRow else {
      fatalError("Error in sengmented selection")
    }
    
    self.vm.selectedType = name
    self.vm.email = email
    
    self.vm.selectedType = self.vm.types[indexPath.row]
    self.vm.selectedSize = selectedSize
    
    WebService().load(resource: Order.create(vm: self.vm)) { result in
      switch result {
      case .success(let order):
        print(order)
      case .failure(let error):
        print("Error", error.localizedDescription)      
      }
    }
    
  }
}
