//
//  WatchTestApp.swift
//  WatchTest WatchKit Extension
//
//  Created by 김광수 on 2022/09/02.
//

import SwiftUI

@main
struct WatchTestApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
