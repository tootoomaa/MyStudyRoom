//
//  ButtonModifier.swift
//  Honeymoon
//
//  Created by 김광수 on 2021/05/05.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Capsule().fill(Color.pink))
            .foregroundColor(.white)
    }
}
