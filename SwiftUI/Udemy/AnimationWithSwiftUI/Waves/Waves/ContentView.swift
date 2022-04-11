//
//  ContentView.swift
//  Waves
//
//  Created by 김광수 on 2022/04/11.
//

import SwiftUI

struct ContentView: View {
    
    @State var animateOffset = false
    @State private var tiltForwardBackward = false
    @State private var upAndDown = false
    @State private var leadingAnchorAnimate = false
    
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            Color.blue.opacity(0.5).edgesIgnoringSafeArea(.all)
            
            // MARK: - WAVE 1
            ZStack {
                WaveCreation(animateOffset: $animateOffset, animatableOffesetTrue: 0.1, animatableOffesetFalse: -0.1, radius: 50, shadowX: 0, shadowY: 50, duration: 2.7, locationOffsetY: -300)
            }
            
            // MARK: - WAVE 2
            ZStack {
                WaveCreation(animateOffset: $animateOffset, animatableOffesetTrue: -0.1, animatableOffesetFalse: 0.1, radius: 40, shadowX: 0, shadowY: 10, duration: 2.5, locationOffsetY: -350)
            }
            
            // MARK: - WAVE 3
            ZStack {
                WaveCreation(animateOffset: $animateOffset, animatableOffesetTrue: 0.1, animatableOffesetFalse: -0.1, radius: 30, shadowX: 0, shadowY: 10, duration: 2.3, locationOffsetY: -400)
            }
            
            BuoyView(tiltForwardBackWard: $tiltForwardBackward,
                     upAndDown: $upAndDown,
                     leadingAnchorAnimate: $leadingAnchorAnimate)
            
            // MARK: - WAVE 4
            ZStack {
                WaveCreation(animateOffset: $animateOffset, animatableOffesetTrue: 0.2, animatableOffesetFalse: -0.2, radius: 20, shadowX: 0, shadowY: 10, duration: 2.7, locationOffsetY: -405)
            }
            
            // MARK: - WAVE 5
            ZStack {
                WaveCreation(animateOffset: $animateOffset, animatableOffesetTrue: -0.2, animatableOffesetFalse: 0.2, radius: 10, shadowX: 0, shadowY: 10, duration: 2.2, locationOffsetY: -410)
            }
            
            // MARK: - WAVE 6
            ZStack {
                WaveCreation(animateOffset: $animateOffset, animatableOffesetTrue: 0.1, animatableOffesetFalse: 0.2, radius: 5, shadowX: 0, shadowY: 5, duration: 2.8, locationOffsetY: -410)
            }
            // MARK: - WAVE 7
            ZStack {
                WaveCreation(animateOffset: $animateOffset, animatableOffesetTrue: 0.1, animatableOffesetFalse: 0.2, radius: 5, shadowX: 0, shadowY: 40, duration: 2.1, locationOffsetY: -500)
            }
            // MARK: - WAVE 8
            ZStack {
                WaveCreation(animateOffset: $animateOffset, animatableOffesetTrue: -0.2, animatableOffesetFalse: 0.1, radius: 5, shadowX: 0, shadowY: 50, duration: 2.9, locationOffsetY: -600)
            }
            
        }.onAppear {
            animateOffset.toggle()
            leadingAnchorAnimate.toggle()
            tiltForwardBackward.toggle()
            upAndDown.toggle()
        }
    }
}

struct WaveCreation: View {
    
    @Binding var animateOffset: Bool
    var animatableOffesetTrue: CGFloat
    var animatableOffesetFalse: CGFloat
    var radius: CGFloat
    var shadowX: CGFloat
    var shadowY: CGFloat
    var duration: Double
    var locationOffsetY: CGFloat
    
    var body: some View {
        ZStack(alignment: .top) {
            WaveView(yOffset: animateOffset ? animatableOffesetTrue : -animatableOffesetFalse)
                .fill(Color.blue)
                .shadow(color: .gray, radius: radius, x: shadowX, y: shadowY)
                .animation(
                    .easeInOut(duration: duration).repeatForever(autoreverses: true),
                    value: animateOffset
                )
        } //: ZSTACK
        .offset(y: locationOffsetY)
        .rotationEffect(.degrees(180))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
