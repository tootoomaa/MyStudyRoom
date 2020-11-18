//
//  Order.swift
//  HotCoffee
//
//  Created by 김광수 on 2020/10/18.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
  case cappuccino
  case latte
  case espressino
  case cortado
}

enum CoffeeSize: String, Codable, CaseIterable {
  case small
  case medium
  case large
}

struct Order: Codable {
  
  let name: String
  let email: String
  let type: CoffeeType
  let size: CoffeeSize
  
}

extension Order {
  
  static var all: Resource<[Order]> = {
    
    guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
      fatalError("URL is Incorrenct")
    }
    
    return Resource<[Order]>(url: url)
    
  }()
  
  static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
    
    let order = Order(vm)
    guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com") else {
      fatalError("URL is Incorrenct")
    }
    
    guard let data = try? JSONEncoder().encode(order) else {
      fatalError("Error encoding order!")
    }
    
    var resource = Resource<Order?>(url: url)
    resource.httpMethod = .post
    resource.body = data
    
    return resource
  }
}

extension Order {
  
  init?(_ vm: AddCoffeeOrderViewModel) {
    
    guard let name = vm.name,
          let email = vm.email,
          let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
          let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
      return nil
    }
    
    self.name = name
    self.email = email
    self.type = selectedType
    self.size = selectedSize
    
  }
}