//
//  CenterModifier.swift
//  Africa
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

struct CenterModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
