//
//  animationExample2.swift
//  SwiftUIAnimation
//
//  Created by 김광수 on 2021/06/28.
//

import SwiftUI

struct animationExample2: View {
    
    @State private var showDetails: Bool = false
    
    var body: some View {
        VStack {
            
            Button("Press Me") {
                self.showDetails.toggle()
            }
            
            HStack {
                Text("🛬")
                    .font(.custom("Arial", size: 100))
                    .offset(x: self.showDetails ? UIScreen.main.bounds.width - 120 : 0)
                    .animation(.interpolatingSpring(mass: 1.0,
                                                    stiffness: 100.0,
                                                    damping: 10,
                                                    initialVelocity: 0))
                
                Spacer()
            }
        }
    }
}

struct animationExample2_Previews: PreviewProvider {
    static var previews: some View {
        animationExample2()
    }
}
