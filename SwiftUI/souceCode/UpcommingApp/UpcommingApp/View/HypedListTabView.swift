//
//  HypedListTabView.swift
//  UpcommingApp
//
//  Created by 김광수 on 2021/03/18.
//

import SwiftUI

struct HypedListTabView: View {
    
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().unselectedItemTintColor = .gray
        UITabBar.appearance().tintColor = .red
    }
    
    var body: some View {
        TabView {
            NavigationView{
                UpcommingView()
            }.tabItem {
                Image(systemName: "calendar.badge.plus")
                Text("Upcoming")
            }
            Text("Hello 2")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Dicover")
                }
            Text("Hello 3")
                .tabItem {
                    Image(systemName: "gobackward")
                    Text("Past")
                        .foregroundColor(.red)
                }
        }
        .accentColor(.red)
    }
}

struct HypedListTabView_Previews: PreviewProvider {
    static var previews: some View {
        HypedListTabView()
    }
}
