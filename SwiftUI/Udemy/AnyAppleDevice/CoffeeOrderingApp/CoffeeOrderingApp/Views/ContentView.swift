//
//  ContentView.swift
//  CoffeeOrderingApp
//
//  Created by 김광수 on 2021/10/17.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var orderListVM = OrderListViewModel()
    @State private var showModel: Bool = false
    
    var body: some View {
        
        NavigationView {
            OrderListView(orders: self.orderListVM.orders)
                .navigationBarTitle("Coffee Orders")
                .navigationBarItems(leading: Button(action: reloadOrders, label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color.white)
                }), trailing: Button(action: showAddCoffeeOrderView, label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color.white)
                }))
                .sheet(isPresented: self.$showModel) {
                    AddCoffeeOrderView(isPresent: self.$showModel)
                }
        }
    }
    
    private func reloadOrders() {
        self.orderListVM.fetchOrders()
    }
    
    private func showAddCoffeeOrderView() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
