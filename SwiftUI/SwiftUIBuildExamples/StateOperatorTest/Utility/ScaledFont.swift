//
//  ScaledFont.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/06.
//

import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
//    var name: String
    var size: CGFloat
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
//        return content.font(.custom(name, size: scaledSize))
        return content.font(.system(size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(size: CGFloat) -> some View {
//        return self.modifier(ScaledFont(name: name, size: size))
        return self.modifier(ScaledFont(size: size))
    }
}
