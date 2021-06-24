//
//  LazyView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/24.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping()  -> Content ) {
        self.build = build
    }
 
    var body: Content {
        build()
    }
}
