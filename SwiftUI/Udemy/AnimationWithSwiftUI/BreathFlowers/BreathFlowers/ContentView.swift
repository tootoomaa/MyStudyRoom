//
//  ContentView.swift
//  BreathFlowers
//
//  Created by 김광수 on 2022/03/30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var petal = false
    @State private var showShadow = false
    @State private var breathInLabel = true
    @State private var breathOutLabel = false
    @State private var breath = false
    @State private var diffuseOnExhale = false
    
    let backgroundColor = Color.black
    @State private var degree: CGFloat = 0.0
    
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            ZStack {
                Text("Breath In")
                    .font(Font.custom("papyrus", size: 35))
                    .foregroundColor(Color(UIColor.green))
                    .opacity(breathInLabel ? 0 : 1)
                    .scaleEffect(breathInLabel ? 0 : 1)
                    .offset(y: -160)
                    .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: breathInLabel)
                
                Text("Breath out")
                    .font(Font.custom("papyrus", size: 35))
                    .foregroundColor(Color(UIColor.orange))
                    .opacity(breathOutLabel ? 0 : 1)
                    .scaleEffect(breathOutLabel ? 0 : 1)
                    .offset(y: -160)
                    .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: breathOutLabel)
                
                VStack {
                    ZStack {
                        // MARK: - Breath
                        Image("breath").resizable().frame(width: 35, height: 125)
                            .offset(y: breath ? 90 : 0)
                            .animation(Animation.timingCurve(0.67, -2.6, 0.32, 0.4).delay(0.05).speed(0.1).repeatForever(autoreverses: true),
                                       value: breath)
                    }
                    .blur(radius: diffuseOnExhale ? 1 : 60)
                    .offset(x: 0, y: diffuseOnExhale ? -25 : -5)
                }
                .shadow(radius: showShadow ? 20 : 0)
                .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: showShadow)
            }
            .onAppear {
                self.breath.toggle()
                self.breathInLabel.toggle()
                self.breathOutLabel.toggle()
                self.diffuseOnExhale.toggle()
                self.showShadow.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
