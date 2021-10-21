//
//  animationCombine.swift
//  SwiftUIAnimation
//
//  Created by 김광수 on 2021/06/28.
//

import SwiftUI

struct animationCombine: View {
    
    @State private var showDetails: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("🚚")
                .font(.custom("Arial", size: 100))
                .scaleEffect(self.showDetails ? 2 : 1)
                .rotationEffect(.degrees(self.showDetails ? 360.0 : 0.0))
                .animation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10, initialVelocity: 0))
            
            Spacer()
            
            Button("Press me") {
                self.showDetails.toggle()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(Color.white)
            
        }
    }
}

struct animationCombine_Previews: PreviewProvider {
    static var previews: some View {
        animationCombine()
    }
}
