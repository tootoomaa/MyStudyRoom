//
//  CircleEmitter.swift
//  WifiLoading
//
//  Created by 김광수 on 2022/04/12.
//

import SwiftUI

struct CircleEmitter: View {
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        Circles()
            .fill(Color.white.opacity(0.75))
            .scaleEffect(isAnimating ? 2 : 0)
            .animation(
                isAnimating
                    ? Animation.spring()                    // 나타날땐 스프링
                    : Animation.easeInOut(duration: 0),     // 사라질땐 바로
                value: isAnimating
            )
    }
}

struct CircleEmitter_Previews: PreviewProvider {
    static var previews: some View {
        CircleEmitter(isAnimating: .constant(true))
    }
}
