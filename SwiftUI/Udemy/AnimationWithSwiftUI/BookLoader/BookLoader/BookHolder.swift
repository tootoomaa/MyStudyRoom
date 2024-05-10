//
//  BookHolder.swift
//  BookLoader
//
//  Created by 김광수 on 2022/04/12.
//

import SwiftUI

struct BookHolder: Shape {
    
    func path(in rect: CGRect) -> Path {
        let cX: CGFloat = rect.midX - 28
        let cY: CGFloat = rect.midY
        
        var path = Path()
        
        path.move(to: CGPoint(x: cX, y: cY))
        path.addLine(to: CGPoint(x: cX, y: cY + 12))
        path.addLine(to: CGPoint(x: cX + 56, y: cY + 12))
        path.addLine(to: CGPoint(x: cX + 56, y: cY))
        return path
    }
    
}

struct BookHolder_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            BookHolder()
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
                .foregroundColor(.white)
        }
    }
}
