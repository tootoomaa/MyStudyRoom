//
//  StartingView.swift
//  SwiftUIBasic
//
//  Created by 김광수 on 2020/12/22.
//

import SwiftUI

struct StartingView: View {
    var body: some View {
        
        VStack {
            
            Button("Tap me!") {
                aaa.foregroundColor(.red)
            }
            .padding()
            
            let aaa = Text("Tap me!")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.largeTitle)
                .cornerRadius(20)

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}
