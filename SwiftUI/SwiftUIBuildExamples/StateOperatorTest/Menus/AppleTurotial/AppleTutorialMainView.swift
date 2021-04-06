//
//  AppleTutorialMainView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import SwiftUI

struct AppleTutorialMainView: View {
    var body: some View {
        VStack {
            List {
//                NavigationLink("Pocketmon", destination: InterfacingWithUIKitView())
            }
            .navigationBarTitle("AppleTutorial")
        }
    }
}

struct AppleTutorialMainView_Previews: PreviewProvider {
    static var previews: some View {
        AppleTutorialMainView()
    }
}
