//
//  LandmarksAppApp.swift
//  LandmarksApp
//
//  Created by 김광수 on 2021/12/06.
//

import SwiftUI

@main
struct LandmarksAppApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
