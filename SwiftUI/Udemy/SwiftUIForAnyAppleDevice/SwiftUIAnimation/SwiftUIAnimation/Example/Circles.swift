//
//  Circles.swift
//  SwiftUIAnimation
//
//  Created by 김광수 on 2021/06/28.
//

import SwiftUI

struct Circles: View {
    
    @State private var firstAnimate: Bool = false
    @State private var secondAnimate: Bool = false
    @State private var thirdAnimate: Bool = false
    
    var body: some View {
        ZStack {
            
            Circle()
                .foregroundColor(.blue.opacity(0.2))
                .frame(width: 300, height: 300)
                .scaleEffect(firstAnimate ? 1.3 : 1)
                .animation(.interpolatingSpring(mass: 5,
                                                stiffness: 100.0,
                                                damping: 10,
                                                initialVelocity: 0))
            
            Circle()
                .foregroundColor(.blue.opacity(0.3))
                .frame(width: 200, height: 200)
                .scaleEffect(secondAnimate ? 1.3 : 1)
                .animation(.interpolatingSpring(mass: 5,
                                                stiffness: 100.0,
                                                damping: 10,
                                                initialVelocity: 0))
            
            Circle()
                .foregroundColor(.blue.opacity(0.4))
                .frame(width: 100, height: 100)
                .scaleEffect(thirdAnimate ? 1.3 : 1)
                .animation(.interpolatingSpring(mass: 5,
                                                stiffness: 100.0,
                                                damping: 10,
                                                initialVelocity: 0))
            
            
            Button("Action") {
                firstAnimate.toggle()
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    secondAnimate.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                    thirdAnimate.toggle()
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(Color.white)
            .offset(y: 300)
        }
    }
}

struct Circles_Previews: PreviewProvider {
    static var previews: some View {
        Circles()
    }
}
