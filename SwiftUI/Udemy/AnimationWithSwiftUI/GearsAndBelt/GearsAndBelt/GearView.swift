//
//  GearView.swift
//  GearsAndBelt
//
//  Created by 김광수 on 2022/04/11.
//

import SwiftUI

struct GearView: View {
    
    @State private var rotateGear = false
    
    var gearImage: String = ""
    var gearWidth: CGFloat = 0.0
    var gearDegrees: Double = 0.0
    var offsetGearX: CGFloat = 0.0
    var offsetGearY: CGFloat = 0.0
    var rotateDegrees: Double = 0.0
    var duration: Double = 0.0
    var xAxis: CGFloat = 0.0
    var yAxis: CGFloat = 0.0
    var zAxis: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Image(gearImage).resizable().aspectRatio(contentMode: .fit)
                .frame(width: gearWidth)
                .rotationEffect(.degrees(rotateGear ? gearDegrees : 0))
                .animation(
                    .linear(duration: duration).repeatForever(autoreverses: false),
                    value: rotateGear
                ) //: Animation
                .rotation3DEffect(
                    .degrees(rotateDegrees),
                    axis: (xAxis, yAxis, zAxis)
                ) //: rotation3DEffect
                .offset(x: offsetGearX, y: offsetGearY)
        } //: ZSTACK
        .onAppear {
            rotateGear.toggle()
        } //: OnAppear
        .shadow(color: .black, radius: 1, x: 0, y: 0)
    } //: BODY
}

struct GearView_Previews: PreviewProvider {
    static var previews: some View {
        GearView(gearImage: "doubleGear", gearWidth: 100, gearDegrees: 360, offsetGearX: 0, offsetGearY: 0, duration: 5)
    }
}
