//
//  CoffeeViewModel.swift
//  CoffeeOrderingApp
//
//  Created by 김광수 on 2021/10/17.
//

import Foundation

class CoffeeListViewModel {
    var coffeeList: [CoffeeViewModel] = [CoffeeViewModel]()
}

class CoffeeViewModel {
    
    var coffee: Coffee
    
    init(coffee: Coffee) {
        self.coffee = coffee
    }
    
    var name: String {
        self.coffee.name
    }
    
    var imageURL: String {
        self.coffee.imageURL
    }
    
    var price: Double {
        self.coffee.price
    }
    
}
