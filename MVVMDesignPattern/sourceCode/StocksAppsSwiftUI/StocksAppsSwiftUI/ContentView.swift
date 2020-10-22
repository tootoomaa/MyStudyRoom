//
//  ContentView.swift
//  StocksAppsSwiftUI
//
//  Created by 김광수 on 2020/10/19.
//

import SwiftUI

struct ContentView: View {
  
  @ObservedObject private var stockListVM = StockListViewModel()
  
  init() {
    UINavigationBar.appearance().backgroundColor = UIColor.black
    UINavigationBar.appearance().largeTitleTextAttributes =
      [NSAttributedString.Key.foregroundColor : UIColor.white]
    UITableView.appearance().backgroundColor = UIColor.black
    UITableViewCell.appearance().backgroundColor = UIColor.black
    
    stockListVM.laod()
  }
  
  var body: some View {
    NavigationView {
      
      ZStack(alignment: .leading) {
        
        Color.black
        
        Text("January 5 2020")
          .font(.custom("Arial", size: 32))
          .fontWeight(.bold)
          .foregroundColor(Color.white)
          .padding(EdgeInsets(top: 9, leading: 20, bottom: 0, trailing: 0))
          .offset(y: -400)
        
        SearchView(searchTerm: self.$stockListVM.searchTerm)
          .offset(y: -350)
        
        StockListView(stocks: self.stockListVM.stocks)
          .offset(y: 150)
         
      }.navigationTitle("Stocks")
    }.edgesIgnoringSafeArea(.all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
