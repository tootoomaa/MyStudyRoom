//
//  Shop.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/15.
//

import Foundation

class Shop: ObservableObject {
    @Published var showingProduct: Bool = false
    @Published var selectedProduct: Product? = nil
}
