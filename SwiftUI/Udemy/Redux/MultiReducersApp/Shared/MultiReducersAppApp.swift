//
//  MultiReducersAppApp.swift
//  Shared
//
//  Created by 김광수 on 2021/12/01.
//

import SwiftUI

@main
struct MultiReducersAppApp: App {
    var body: some Scene {
        WindowGroup {
            
            let store = Store(reducer: appReducer,
                              state: AppState(),
                              middlewares: [logMiddleware(),
                                            incrementMiddleware()]) // Only fire when IncrementAcion occur
            
            ContentView()
                .environmentObject(store)
        }
    }
}
