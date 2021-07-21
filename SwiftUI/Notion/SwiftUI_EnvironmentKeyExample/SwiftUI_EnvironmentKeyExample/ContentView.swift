//
//  ContentView.swift
//  SwiftUI_EnvironmentKeyExample
//
//  Created by 김광수 on 2021/07/21.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.myCustomValue) var customValue: String
    var newString: String = ""
    
    init() {
        print("Init: start")
        self.newString = customValue + "+ New" // default Value
        print("Init: Complete")
    }
    
    var body: some View {
        Text(customValue)
            .padding()
        
        Text(newString)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
