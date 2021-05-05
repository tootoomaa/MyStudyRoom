//
//  AnyTransition.swift
//  Honeymoon
//
//  Created by 김광수 on 2021/05/05.
//

import SwiftUI

extension AnyTransition {
    
    static var tailingBotton: AnyTransition {
        
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(edge: .trailing)
                .combined(with: .move(edge: .bottom))
        )
    }
    
    static var leadingButton: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom))
        )
    }
    
}
