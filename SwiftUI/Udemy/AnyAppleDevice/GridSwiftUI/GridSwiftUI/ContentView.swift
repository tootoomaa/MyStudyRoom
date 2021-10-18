//
//  ContentView.swift
//  GridSwiftUI
//
//  Created by 김광수 on 2021/10/11.
//

import SwiftUI

struct ContentView: View {
    
    let animals = ["🦅","🦆","🦉","🦇","🐗","🐺","🐥","🦌","🐃","🐆","🐫","🐑","🐈","🦩"]
    
    let screenWidth = UIScreen.main.bounds.width
    @State private var slideValue: CGFloat = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Slider(value: $slideValue, in: 1...8, step: 1)
                Text(String(format: "%.0f", self.slideValue))
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(Color.white)
                    .clipShape(Circle())
                
                List(self.animals.chunks(size: Int(self.slideValue)), id: \.self) { chunk in
                    ForEach(chunk, id: \.self) { animal in
                        Text(animal)
                            .font(.system(size: CGFloat(200/self.slideValue)))
                    }
                } //: LIST
            } //: VSTACK
            .navigationBarTitle("Animals")
        } //: Navigation View
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
