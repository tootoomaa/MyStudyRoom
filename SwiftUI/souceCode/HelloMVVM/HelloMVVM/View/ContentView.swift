//
//  ContentView.swift
//  HelloMVVM
//
//  Created by 김광수 on 2021/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var counterVM: CounterViewModel
    
    init() {
        counterVM = CounterViewModel()
    }
    
    var body: some View {
        
        VStack {
            Text(counterVM.premium ? "PREMIUM" : "")
                .foregroundColor(.green)
                .frame(width: 200, height: 100)
                .font(.largeTitle)
            
            Text("\(counterVM.value)")
                .font(.title)
            
            Button("Increment") {
                self.counterVM.addValue()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
