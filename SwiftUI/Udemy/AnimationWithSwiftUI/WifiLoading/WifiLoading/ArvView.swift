//
//  ArvView.swift
//  WifiLoading
//
//  Created by 김광수 on 2022/04/12.
//

import SwiftUI

struct ArvView: View {
    
    var radius: CGFloat
    @Binding var isAnimate: Bool
    @Binding var fillColor: Color
    @Binding var shadowColor: Color
    
    var body: some View {
        ArcShape(raduis: radius)
            .fill(fillColor)
            .shadow(color: shadowColor, radius: 5)
            .frame(height: radius)
            .animation(.spring().speed(0.75), value: isAnimate)
            .onTapGesture {
                
            }
    }
}

struct ArcShape: Shape {
    var raduis: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                 radius: raduis,
                 startAngle: .degrees(220),
                 endAngle: .degrees(320),
                 clockwise: false)                              // 위쪽으로 생성
        
        return p.strokedPath(.init(lineWidth: 6, lineCap: .round))
    }
}

struct ArvView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ArvView(
                radius: 42,
                isAnimate: .constant(true),
                fillColor: .constant(Color.green),
                shadowColor: .constant(Color.red)
            )
        }
    }
}
