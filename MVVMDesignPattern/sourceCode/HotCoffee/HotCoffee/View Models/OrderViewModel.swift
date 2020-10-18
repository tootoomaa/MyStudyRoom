//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by 김광수 on 2020/10/18.
//

import Foundation

class OrderListViewModel {
  
  var ordersViewModel: [OrderViewModel]
  
  init() {
    self.ordersViewModel = [OrderViewModel]()
  }
}

extension OrderListViewModel {
  
  func orderViewModel(at Index: Int) -> OrderViewModel {
    return self.ordersViewModel[Index]
  }
  
}


struct OrderViewModel {
  let order: Order
}

extension OrderViewModel {
  
  var name: String {
    return self.order.name
  }
  
  var email: String {
    return self.order.email
  }
  
  var type: String {
    return self.order.type.rawValue.capitalized
  } 
  
  var size: String {
    return self.order.size.rawValue.capitalized
  }
}
