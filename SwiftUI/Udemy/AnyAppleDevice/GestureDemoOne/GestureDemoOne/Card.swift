//
//  Card.swift
//  GestureDemoOne
//
//  Created by 김광수 on 2021/10/18.
//

import SwiftUI

struct Card: View {
    
    let tapped: Bool
    @State private var scale: CGFloat = 1
    
    var body: some View {
        VStack {
            
            Image("cat")
                .resizable()
                .scaleEffect(self.scale)
                .frame(width: 300, height: 300)
                .gesture(MagnificationGesture()
                            .onChanged({ value in
                                self.scale = value.magnitude
                            })
                )
            
            
            Text("Card")
                .font(.largeTitle)
                .foregroundColor(Color.white)
            
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(self.tapped ? Color.orange : Color.purple)
        .cornerRadius(20)
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(tapped: false)
    }
}
