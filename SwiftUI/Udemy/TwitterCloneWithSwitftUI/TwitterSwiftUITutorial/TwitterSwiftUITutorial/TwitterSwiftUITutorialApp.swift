//
//  TwitterSwiftUITutorialApp.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/15.
//

import SwiftUI
import Firebase

@main
struct TwitterSwiftUITutorialApp: App {
    // MARK: - Properties
    
    
    
    // MARK: - Init
    init() {
        FirebaseApp.configure()
    }
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel.shared)
        }
    }
}
