//
//  View+Extensions.swift
//  SwiftUI_EnvironmentKeyExample
//
//  Created by 김광수 on 2021/07/21.
//

import SwiftUI

extension View {
    func myCustomValue(_ myCustomValue: String) -> some View {
        print("View Extension Start")
        return environment(\.myCustomValue, myCustomValue)
    }
}
