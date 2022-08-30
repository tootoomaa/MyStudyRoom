//
//  HelloCoreDataApp.swift
//  HelloCoreData
//
//  Created by 김광수 on 2022/08/29.
//

import SwiftUI

@main
struct HelloCoreDataApp: App {
    
    let coreDM: CoreDataManager
    
    init() {
        self.coreDM = CoreDataManager()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: coreDM)
        }
    }
}
