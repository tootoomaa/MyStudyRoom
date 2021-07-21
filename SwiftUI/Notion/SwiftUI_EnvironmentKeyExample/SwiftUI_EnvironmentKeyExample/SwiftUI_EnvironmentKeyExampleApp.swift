//
//  SwiftUI_EnvironmentKeyExampleApp.swift
//  SwiftUI_EnvironmentKeyExample
//
//  Created by 김광수 on 2021/07/21.
//

import SwiftUI

@main
struct SwiftUI_EnvironmentKeyExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.myCustomValue, "AnoterString")
                .myCustomValue("Anthoer String")
        }
    }
}
