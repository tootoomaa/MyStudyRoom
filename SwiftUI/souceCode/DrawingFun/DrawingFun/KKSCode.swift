//
//  KKSCode.swift
//  DrawingFun
//
//  Created by 김광수 on 2021/01/31.
//

import SwiftUI

struct KKSCode: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                path.move(to: CGPoint(x: 20, y: 0))
                path.addLine(to: CGPoint(x: geometry.size.width/2,
                                         y: geometry.size.height/2))
//                path.move(to: CGPoint(x: 0, y: 500))
                path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                
            }.fill(Color.red)
            //.stroke(Color.green, lineWidth: 10)
        }
    }
}

struct KKSCode_Previews: PreviewProvider {
    static var previews: some View {
        KKSCode()
    }
}
