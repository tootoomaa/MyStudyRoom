//
//  ContentView.swift
//  FlyingBird
//
//  Created by 김광수 on 2022/04/05.
//

import SwiftUI

struct ContentView: View {
    
    @State private var leftWing = false
    @State private var rightWing = false
    @State private var birdBody = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                // MARK: - LEFT WING
                Image("leftWing").resizable().frame(width: 150, height: 150)
                    .shadow(color: .red, radius: 1, x: 0, y: 3)
                    .rotationEffect(.degrees(leftWing ? -100 : 0), anchor: .bottomTrailing)
                    .offset(x: -55, y: leftWing ? -190 : 0)
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: leftWing)
                
                // MARK: - RIGHT WING
                Image("rightWing").resizable().frame(width: 150, height: 150)
                    .shadow(color: .blue, radius: 1, x: 0, y: 3)
                    .rotationEffect(.degrees(leftWing ? 100 : 0), anchor: .bottomLeading)
                    .offset(x: 55, y: leftWing ? -190 : 0)
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: leftWing)
                
                // MARK: - BODY
                Image("body").resizable().frame(width: 125, height: 150)
                    .offset(y: -30)
                    .shadow(color: .white, radius: 1, x: 0, y: 0)
                    .offset(y: birdBody ? -50 : 75)
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: birdBody)
            }
            .shadow(color: .white, radius: 1, x: 0, y: 7)
            .onAppear{
                birdBody.toggle()
                leftWing.toggle()
                rightWing.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
