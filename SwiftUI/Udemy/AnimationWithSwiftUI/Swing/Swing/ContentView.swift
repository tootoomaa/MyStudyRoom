//
//  ContentView.swift
//  Swing
//
//  Created by 김광수 on 2022/04/06.
//

import SwiftUI

struct ContentView: View {
    
    @State private var girlInSwingAnimate = false
    @State private var leftLegAnimate = false
    @State private var rightLegAnimate = false
    let fadeGradient = Gradient(colors: [.clear, .black])
    
    var body: some View {
        ZStack {
            
            Image("tree").resizable()
                .frame(width: 950, height: 900)
            
            ZStack {
                
                // MARK: - ROPE PIECE
                // top left
                Image("rope").resizable().aspectRatio(contentMode: .fit)
                    .mask(LinearGradient(gradient: fadeGradient, startPoint: .top, endPoint: .bottom))
                //                .rotationEffect(.degrees(90))
                    .frame(width: 6, height: 100)
                    .offset(x: -3, y: 35)
                
                // top right
                Image("rope").resizable().aspectRatio(contentMode: .fit)
                    .mask(LinearGradient(gradient: fadeGradient, startPoint: .top, endPoint: .bottom))
                //                .rotationEffect(.degrees(90))
                    .frame(width: 6, height: 100)
                    .offset(x: 24, y: 35)
                
                // middle right
                Image("rope").resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 6, height: 100)
                    .offset(x: 24, y: 80)
                
                // middle left
                Image("rope").resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 6, height: 100)
                    .offset(x: -3, y: 80)
                
                // MARK: - LEGS
                Image("leftLeg").resizable().aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(leftLegAnimate ? 65 : -5), anchor: .leading)
                    .scaleEffect(0.15)
                    .animation(.easeInOut(duration: 0.5).delay(1).repeatForever(autoreverses: true), value: leftLegAnimate)
                    .offset(x: 70, y: 175)
                    .onAppear{ leftLegAnimate.toggle() }
                
                Image("rightLeg").resizable().aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(leftLegAnimate ? 0 : 70), anchor: .leading)
                    .scaleEffect(0.15)
                    .offset(x: 70, y: 175)
                    .animation(.easeInOut(duration: 0.5).delay(0.9).repeatForever(autoreverses: true), value: rightLegAnimate)
                    .onAppear { rightLegAnimate.toggle() }
                
                // MARK: - GIRL IN SWING
                Image("swingLady").resizable().aspectRatio(contentMode: .fit)
                    .scaleEffect(0.15)
                    .offset(y: 140)
            }
            .rotationEffect(.degrees(girlInSwingAnimate ? 12 : -5), anchor: .top)
            .animation(Animation.easeInOut(duration: 1).delay(0.09).repeatForever(autoreverses: true), value: girlInSwingAnimate)
            .onAppear { girlInSwingAnimate.toggle() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

