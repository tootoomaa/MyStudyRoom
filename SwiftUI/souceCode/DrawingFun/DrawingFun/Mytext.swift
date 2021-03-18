//
//  Mytext.swift
//  DrawingFun
//
//  Created by 김광수 on 2021/01/31.
//

import SwiftUI

struct Mytext: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: geometry.size.width,
                                         y: geometry.size.height))
            }.stroke()
        }
    }
}

struct Mytext_Previews: PreviewProvider {
    static var previews: some View {
        Mytext()
    }
}
