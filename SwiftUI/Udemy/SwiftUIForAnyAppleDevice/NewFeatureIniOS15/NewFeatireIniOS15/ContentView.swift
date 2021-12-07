//
//  ContentView.swift
//  AysncImageTestApp
//
//  Created by 김광수 on 2021/12/04.
//

import SwiftUI

enum TestCase: String, CaseIterable {
    case asyncImageView
    case pulltoRefreshView
    case timeLineView
    case searchableList
    case swipeAction
    case material
    
    var view: AnyView {
        switch self {
        case .asyncImageView:       return AnyView(AsyncImageView())
        case .pulltoRefreshView:    return AnyView(PulltoRefreshView())
        case .timeLineView:         return AnyView(MyTimeLineView())
        case .searchableList:       return AnyView(MySearchableView())
        case .swipeAction:          return AnyView(MySwipeActionView())
        case .material:             return AnyView(MyMaterialView())
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(TestCase.allCases, id: \.self) { menu in
                NavigationLink {
                    menu.view
                } label: {
                    Text(menu.rawValue)
                }
            }.navigationTitle("New In iOS 15")
        } //: Navigation View
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
