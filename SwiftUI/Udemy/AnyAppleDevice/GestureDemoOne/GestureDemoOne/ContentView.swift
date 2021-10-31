//
//  ContentView.swift
//  GestureDemoOne
//
//  Created by 김광수 on 2021/10/18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tapped: Bool = false
    @State private var cardDragState = CGSize.zero
    @State private var cardRotationState: Double = 0
    
    var body: some View {
        Card(tapped: self.tapped)
            .offset(y: cardDragState.height)
            .rotationEffect(Angle(degrees: cardRotationState))
            .gesture(RotationGesture()
                        .onChanged({ value in
                            self.cardRotationState = value.degrees
                        })
            )
            .gesture(DragGesture()
                        .onChanged({ value in
                            self.cardDragState = value.translation
                        })
                        .onEnded({ value in
                            self.cardDragState = CGSize.zero
                        })
            )
            .animation(.spring())
            .gesture(TapGesture(count: 1)
                        .onEnded({ _ in
                            self.tapped.toggle()
                        })
            )
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
