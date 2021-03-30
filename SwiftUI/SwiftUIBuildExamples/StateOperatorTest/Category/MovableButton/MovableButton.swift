//
//  MovableButton.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/30.
//

import SwiftUI

struct MovableButton: View {
    
    @State private var fastTimeDragAmount: CGPoint?
    @State private var lateTimeDragAmount: CGPoint?
    
    @State var offset = CGPoint(x: 0, y: 0)
    
    var body: some View {
        
        GeometryReader { gp in // just to center initial position
            ZStack {
                
                Circle()
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .frame(width: gp.size.width*0.7, height: gp.size.width*0.7)
                
                Circle()
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .frame(width: gp.size.width*0.5, height: gp.size.width*0.5)

                
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .foregroundColor(.blue)
                            .frame(width: gp.size.width*0.1, height: gp.size.width*0.1)
                        Text("Move me")
                            .foregroundColor(.white)
                            .font(.system(.caption, design: .serif))
                    }
                }
                .animation(.default)
                .position(self.fastTimeDragAmount ?? CGPoint(x: gp.size.width / 2,
                                                     y: gp.size.height / 2))
                .highPriorityGesture(  // << to do no action on drag !!
                    DragGesture()
                        .onChanged { self.fastTimeDragAmount = $0.location})
                
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: gp.size.width*0.1, height: gp.size.width*0.1)
                        Text("Move me")
                            .foregroundColor(.white)
                            .font(.system(.caption, design: .serif))
                    }
                }
                .animation(.default)
                .position(self.lateTimeDragAmount ?? CGPoint(x: gp.size.width / 2,
                                                     y: gp.size.height / 2))
                .highPriorityGesture(  // << to do no action on drag !!
                    DragGesture()
                        .onChanged { self.lateTimeDragAmount = $0.location})
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // full space
        }
    }
    
    func changeLocate(locate: CGPoint) -> CGPoint {
        
        let x = locate.x
        let y = locate.y
        
        
        return locate
    }
}

struct MovableButton_Previews: PreviewProvider {
    static var previews: some View {
        MovableButton()
    }
}
