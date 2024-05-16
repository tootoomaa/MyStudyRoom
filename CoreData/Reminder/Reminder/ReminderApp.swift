//
//  ReminderApp.swift
//  Reminder
//
//  Created by 김광수 on 2022/09/26.
//

import SwiftUI

@main
struct ReminderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CategoryLiseView()
                .environmentObject(ReminderManager(context: persistenceController.container.viewContext))
        }
    }
}
