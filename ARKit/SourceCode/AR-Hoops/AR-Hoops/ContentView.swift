//
//  ContentView.swift
//  AR-Hoops
//
//  Created by 김광수 on 2022/03/30.
//

import SwiftUI
import ARKit

struct ContentView: View {
    
    @State private var isHideDetectedString: Bool = true
    
    var body: some View {
        ZStack {
            ARCustomView(isHideDetectedString: $isHideDetectedString)
            
            VStack {
                
                Image("ic_add")
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Text("Detected Horizontal Plan")
                    .opacity(isHideDetectedString ? 0 : 1)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
