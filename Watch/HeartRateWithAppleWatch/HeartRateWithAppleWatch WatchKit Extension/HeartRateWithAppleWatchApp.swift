//
//  HeartRateWithAppleWatchApp.swift
//  HeartRateWithAppleWatch WatchKit Extension
//
//  Created by 김광수 on 2021/04/08.
//

import SwiftUI

@main
struct HeartRateWithAppleWatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
