//
//  BeltView.swift
//  GearsAndBelt
//
//  Created by 김광수 on 2022/04/11.
//

import SwiftUI

struct BeltView: View {
    
    @State var animateBelt: Bool = false
    
    var beltWidth: CGFloat = 0.0
    var beltHeight: CGFloat = 0.0
    var offsetBeltX: CGFloat = 0.0
    var offsetBeltY: CGFloat = 0.0
    var dashPhaseValue: CGFloat = 40
    
    var rotateDegree: Double = 0.0
    
    var xAxis: CGFloat = 0.0
    var yAxis: CGFloat = 0.0
    var zAsix: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Capsule()
                .trim(from: 0, to: 1)
                .stroke(
                    Color.black,
                    style: StrokeStyle(lineWidth: 7, lineCap: .round, dash: [5, 5], dashPhase: animateBelt ? dashPhaseValue : 0)
                ) //: Strock
                .frame(width: beltWidth, height: beltHeight)
                .animation(
                    .linear(duration: 3).repeatForever(autoreverses: false).speed(3),
                    value: animateBelt
                ) //: Animate
                .onAppear {
                    animateBelt.toggle()
                } //: OnApear
        } //: ZSTACK
        .shadow(color: .black, radius: 1, x: 1, y: 0) 
        .rotationEffect(.degrees(rotateDegree), anchor: .center)
        .offset(x: offsetBeltX, y: offsetBeltY)
    }
}

struct BeltView_Previews: PreviewProvider {
    static var previews: some View {
        BeltView(animateBelt: true, beltWidth: 380, beltHeight: 48, offsetBeltX: 0, offsetBeltY: 0, rotateDegree: 0)
            .previewLayout(.fixed(width: 100, height: 400))
    }
}
