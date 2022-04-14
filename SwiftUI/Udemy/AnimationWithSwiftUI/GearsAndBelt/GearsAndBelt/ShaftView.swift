//
//  ShaftView.swift
//  GearsAndBelt
//
//  Created by 김광수 on 2022/04/11.
//

import SwiftUI

struct ShaftView: View {
    
    var width: CGFloat = 0.0
    var motionOffsetX: CGFloat = 0.0
    var motionOffsetY: CGFloat = 0.0
    @State var animateRect: Bool = false
    
    var body: some View {
        ZStack {
            Image("shaft").resizable().frame(width: width, height: 40)
            ShaftMotionView(motionWidth: width - 30, motionOffsetY: -7)
        }
    }
}

struct ShaftMotionView: View {
    
    var motionWidth: CGFloat = 0.0
    var motionOffsetX: CGFloat = 0.0
    var motionOffsetY: CGFloat = 0.0
    
    @State private var animateRect: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle().frame(width: motionWidth, height: 8)
                .foregroundColor(.black)
                .cornerRadius(5)
                .opacity(animateRect ? 0 : 0.3)
                .animation(
                    .easeInOut(duration: 0.5).repeatForever(autoreverses: true),
                    value: animateRect
                )
                .onAppear() {
                    animateRect.toggle()
                } //: onAppear
        } //: ZSTACK
        .offset(x: motionOffsetX, y: motionOffsetY)
    }
}

struct ShaftView_Previews: PreviewProvider {
    static var previews: some View {
        ShaftView(width: 200)
            .overlay(
                ShaftMotionView(
                    motionWidth: 180,
                    motionOffsetX: 0,
                    motionOffsetY: -7
                )
            )
    }
}
