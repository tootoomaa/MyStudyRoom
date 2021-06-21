//
//  CleanArchitectureExampleApp.swift
//  CleanArchitectureExample
//
//  Created by 김광수 on 2021/06/06.
//

import SwiftUI

@main
struct CleanArchitectureExampleApp: App {
    
    @EnvironmentObject var appState: AppState
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
