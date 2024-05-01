//
//  HearRateTestApp.swift
//  HearRateTest
//
//  Created by 김광수 on 2022/11/30.
//

import SwiftUI

@main
struct HearRateTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
