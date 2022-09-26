//
//  ContentView.swift
//  WatchTest WatchKit Extension
//
//  Created by 김광수 on 2022/09/02.
//

import SwiftUI

struct ContentView: View {
    @State private var manager = MotionManager()
    
    var body: some View {
        VStack {
            Text(manager.statusString)
                .font(.subheadline)
            
            Text(manager.value)
                .font(.title)
            
            HStack(spacing: 5) {
                Button("Start", action: {
                    manager.startMotionTracking()
                })
                
                Button("End", action: {
                    manager.stopMotionTracking()
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
