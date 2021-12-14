//
//  ContentView.swift
//  ARKitVision
//
//  Created by 김광수 on 2021/12/14.
//

import SwiftUI

enum Menu: String, CaseIterable {
    case arWithVision
    case arsession
    
    var getView: AnyView {
        switch self {
        case .arsession:        return AnyView(ArsessionView())
        case .arWithVision:     return AnyView(ArWithVisionView())
        }
    }
}

struct ContentView: View {
    
    let menus: [Menu] = Menu.allCases
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(menus, id: \.self) { menu in
                    NavigationLink { menu.getView } label: {
                        Text(menu.rawValue)
                    }
                }
            }.navigationTitle("003 Test")
        }
    }
}
