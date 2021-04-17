//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by 김광수 on 2021/04/17.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard()  {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#endif
