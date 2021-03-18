//
//  ContentView.swift
//  DrawingFun
//
//  Created by 김광수 on 2021/01/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Circle()
                .fill(Color.red)
                .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                .shadow(radius: 30)
                .padding(30)
                .frame(height: 100)
            KKSCode()
                .frame(height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
