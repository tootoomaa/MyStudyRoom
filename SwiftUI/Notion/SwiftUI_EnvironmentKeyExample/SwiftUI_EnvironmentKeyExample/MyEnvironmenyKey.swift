//
//  MyEnvironmenyKey.swift
//  SwiftUI_EnvironmentKeyExample
//
//  Created by 김광수 on 2021/07/21.
//

import SwiftUI

private struct MyEnvironmentKey: EnvironmentKey {
    typealias Value = String
    
    static let defaultValue: Value = "Default value"
}

extension EnvironmentValues {
    var myCustomValue: String {                         // 변수 생성
        get { print("Get Env Key"); return self[MyEnvironmentKey.self] }
        set { print("Set Env Key"); self[MyEnvironmentKey.self] = newValue }
    }
}

