//
//  ContentView.swift
//  Fructus
//
//  Created by 김광수 on 2021/04/06.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    var fruits: [Fruit] = fruitsData
    
    @State private var isShowingSetting: Bool = false
    
    var body: some View {
        NavigationView {
            List(fruits.shuffled()) { fruit in
                NavigationLink(
                    destination: FruitDetailView(fruit: fruit)) {
                    FruitRowView(fruit: fruit)
                        .padding(.vertical, 4)
                }
            }
            .navigationTitle("Furits")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        isShowingSetting = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                    }) //: Button
            .sheet(isPresented: $isShowingSetting) {
                SettingsView()
            }
        } //: Navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}
