//
//  ChallengeNotificationViewSpringAnimation.swift
//  SwiftUIAnimation
//
//  Created by 김광수 on 2021/06/28.
//

import SwiftUI

struct ChallengeNotificationViewSpringAnimation: View {
    
    @State private var isShow: Bool = false
    
    var body: some View {
        VStack {
            
            Text("Success")
                .frame(width: 380, height: 60)
                .foregroundColor(.white)
                .background(Color.green.opacity(0.7))
                .cornerRadius(20)
                .offset(y: isShow ? -360 : -500)
                .animation(.interpolatingSpring(mass: 1,
                                                stiffness: 100.0,
                                                damping: 10,
                                                initialVelocity: 0))
            
            Button("Button") {
                isShow.toggle()
            }
            
        }
    }
}

struct ChallengeNotificationViewSpringAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeNotificationViewSpringAnimation()
    }
}
