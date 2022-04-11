//
//  WaveView.swift
//  Waves
//
//  Created by 김광수 on 2022/04/11.
//

import SwiftUI

struct WaveView: Shape {
    
    var yOffset: CGFloat = 0.1
    
    var animatableData: CGFloat {
        get { return yOffset }
        set { yOffset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)                                    // 왼쪽 상단
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))   // 오른쪽 상단
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))   // 오른쪽 하단
        // 밑줄 커브 생성
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX*0.75, y: rect.maxY - rect.maxY*yOffset),
                      control2: CGPoint(x: rect.maxX*0.25, y: rect.maxY + rect.maxY*yOffset))
        
        path.closeSubpath()
        return path
    }
}

struct WaveView_Previews: PreviewProvider {
    static var previews: some View {
        WaveView(yOffset: 0.5)
            .stroke(Color.red, lineWidth: 3)
            .frame(height: 200)
            .padding()
            .previewDisplayName("Wave")
    }
}
