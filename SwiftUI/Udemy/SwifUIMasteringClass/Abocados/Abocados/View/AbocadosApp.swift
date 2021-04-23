//
//  AbocadosApp.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/23.
//

import SwiftUI

@main
struct AbocadosApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                AvocadosView()
                    .tabItem {
                        Image("tabicon-branch")
                        Text("Avocados")
                    } //: TabItem
                
                ContentView()
                    .tabItem {
                        Image("tabicon-book")
                        Text("Recipes")
                    } //: TabItem
                
                RipeningStagesView()
                    .tabItem {
                        Image("tabicon-avocado")
                        Text("Ripening")
                    } //: TabItem
                
                SettingView()
                    .tabItem {
                        Image("tabicon-settings")
                        Text("Setting")
                    } //: TabItem
                
            } //: TabView
            .edgesIgnoringSafeArea(.top)
            .accentColor(Color.primary)
        }
    }
}
