//
//  PhoneWithWatchApp.swift
//  PhoneWithWatch WatchKit Extension
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

@main
struct PhoneWithWatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
