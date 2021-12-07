//
//  CustomerListViewModel.swift
//  AysncImageTestApp
//
//  Created by 김광수 on 2021/12/04.
//

import Foundation

class CustomerListViewModel: ObservableObject {
    
    @Published var customers: [String] = []
    
    func fetch() {
        
        let letters = "abcdefghi"
        var names: [String] = []
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            for _ in 0..<20 {
                let randomName = String((0...letters.count).map { _ in letters.randomElement()! })
                names.append(randomName)
            }
            
            self.customers = names
        }
    }
}
