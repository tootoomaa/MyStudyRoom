//
//  BuoyView.swift
//  Waves
//
//  Created by 김광수 on 2022/04/11.
//

import SwiftUI

struct BuoyView: View {
    
    @Binding var tiltForwardBackWard: Bool
    @Binding var upAndDown: Bool
    @Binding var leadingAnchorAnimate: Bool
    
    @State private var red = 1.0
    @State private var green = 1.0
    @State private var blue = 1.0
    
    var body: some View {
        ZStack {
            Image("buoy").overlay(
                Rectangle().overlay(Color(red: red, green: green, blue: blue))
                    .cornerRadius(5)
                    .frame(width: 11, height: 16)
                    .position(x: 113, y: 22)
            ) //: OverLay
            // tilt
            .rotationEffect(.degrees(tiltForwardBackWard ? 7 : -3), anchor: .leading)
            .animation(.easeOut(duration: 1).repeatForever(autoreverses: true), value: leadingAnchorAnimate)
            // Leading Anchor Animation
            .animation(
                .easeOut(duration: 0.9).repeatForever(autoreverses: true),
                value: leadingAnchorAnimate
            ) //: Animation
            .offset(y: upAndDown ? -10 : 10)
            .animation(
                .easeOut(duration: 1.0).delay(0.2).repeatForever(autoreverses: true),
                value: upAndDown)
            .onAppear {
                upAndDown.toggle()
                red = 0.5
                green = 0.5
                blue = 0.5
            }
        }
    }
}

struct BuoyView_Previews: PreviewProvider {
    static var previews: some View {
        BuoyView(tiltForwardBackWard: .constant(false),
                 upAndDown: .constant(false),
                 leadingAnchorAnimate: .constant(false))
    }
}
