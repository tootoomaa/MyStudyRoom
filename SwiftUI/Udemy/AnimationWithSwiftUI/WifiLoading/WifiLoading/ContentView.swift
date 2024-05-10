//
//  ContentView.swift
//  WifiLoading
//
//  Created by 김광수 on 2022/04/12.
//

import SwiftUI

extension Color {
    static let wifiBackground: Color = Color(r: 5, g: 23, b: 46)
    static let wifiShadow: Color = Color(r: 13, g: 50, b: 125)
    static let wifiConnected: Color = Color(r: 170, g: 255, b: 197)
    
    init(r: Double, g: Double, b: Double) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0)
    }
}

struct ContentView: View {
    
    @State var isAnimating: Bool = false
    @State var isConnected: Bool = false
    
    @State var circleOffset: CGFloat = 20
    @State var smallArcOffset: CGFloat = 16
    @State var mediumArcOffset: CGFloat = 14.5
    @State var largeArcOffset: CGFloat = 14
    
    @State var arcColor: Color = Color.white
    @State var shadowColor: Color = Color.blue
    
    @State var wifiHeaderLabel: String = "Wi - Fi"
    
    static var animationMovingUpwards: Bool = false
    static var rotateArc: Bool = true
    
    var animationDuration: Double = 0.35
    
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            Color.wifiBackground.edgesIgnoringSafeArea(.all)
            
            // MARK: - EMITTER ANIMATION
            CircleEmitter(isAnimating: $isAnimating)
                .offset(y: 90)
                .frame(height: 300)
            
            // MARK: - CIRCLES ANDD ARCs
            ZStack {
                Circle()
                    .fill(arcColor)
                    .scaleEffect(0.7)
                    .frame(width: 10, height: 10)
                    .shadow(color: Color.blue, radius: 5)
                    .offset(y: circleOffset)
                    .animation(.easeOut(duration: animationDuration), value: isAnimating)
                
                ZStack {
                    ArvView(radius: 12, isAnimate: $isAnimating, fillColor: $arcColor, shadowColor: $shadowColor)
                        .rotationEffect(getRotate(arcBoolean: Self.rotateArc))
                        .offset(y: smallArcOffset)
                        .animation(.easeOut(duration: animationDuration), value: isAnimating)
                    
                    ArvView(radius: 24, isAnimate: $isAnimating, fillColor: $arcColor, shadowColor: $shadowColor)
                        .rotationEffect(getRotate(arcBoolean: Self.rotateArc))
                        .offset(y: mediumArcOffset)
                        .animation(.easeOut(duration: animationDuration).delay(animationDuration), value: isAnimating)
                    
                    ArvView(radius: 36, isAnimate: $isAnimating, fillColor: $arcColor, shadowColor: $shadowColor)
                        .rotationEffect(getRotate(arcBoolean: Self.rotateArc))
                        .offset(y: largeArcOffset)
                        .animation(.easeOut(duration: animationDuration).delay(animationDuration * 1.9), value: isAnimating)
                    
                    //outside circle
                    Circle().stroke(style: StrokeStyle(lineWidth: 2.5))
                        .foregroundColor(.white)
                        .opacity(0.8)
                    Circle().fill(Color.blue.opacity(0.1))
                    
                    //animating fill circle
                    Circle().fill(Color.blue.opacity(0.025))
                        .scaleEffect(isAnimating ? 5 : 0)
                        .animation(
                            isAnimating
                            ? .easeIn(duration: animationDuration * 2.5).repeatForever(autoreverses: false)
                            : .linear(duration: 0)
                            , value: isAnimating
                        )
                }
                .onTapGesture {
                    isAnimating.toggle()
                    wifiHeaderLabel = "Searching"
                    smallArcOffset -= 7.5
                    circleOffset -= 15
                    mediumArcOffset = -5.5
                    largeArcOffset = -19
                    isConnected = false
                    arcColor = .white
                    shadowColor = .blue
                    
                    // MARK: - FIRST TIMER
                    Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { arcTimer in
                        if isAnimating {
                            
                        }
                    }
                }
            }.frame(height: 120)
            
        }
    }
    
    func getRotate(arcBoolean: Bool) -> Angle {
        if isAnimating && arcBoolean {
            return Angle.degrees(180)
        }
        return Angle.degrees(0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
