//
//  HelloReduxAppApp.swift
//  HelloReduxApp
//
//  Created by 김광수 on 2021/11/30.
//

import SwiftUI

@main
struct HelloReduxAppApp: App {
    
    
    var body: some Scene {
        
        let store = Store(reducer: reducer)
        
        
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
