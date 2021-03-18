//
//  GragidentView.swift
//  DrawingFun
//
//  Created by 김광수 on 2021/01/31.
//

import SwiftUI

struct GragidentView: View {
    var body: some View {
        
        GeometryReader{ geometry in
            Path { path in
                
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                
            }.fill(LinearGradient(gradient: Gradient(colors: [.red, .purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            
        }
        
    }
}

struct GragidentView_Previews: PreviewProvider {
    static var previews: some View {
        GragidentView()
    }
}
