//
//  ContentView.swift
//  Shared
//
//  Created by 김광수 on 2022/03/30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var rotateRecord = false
    @State private var rotateArm = false
    @State private var shouldAnimate = false
    @State private var degree = 0.0
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.white, .black]), center: .center, startRadius: 20, endRadius: 600)
                .scaleEffect(1.2)
            
            // MARK: - Recoard Player Box
            RecordPlayerBox()
                .offset(y: -80)
            
            VStack {
                // MARK: - Record
                RecordView(degree: $degree, shouldAnimate: $shouldAnimate)
                
                // MARK: - Arm
                ArmView(rotateArm: $rotateArm)
                
                // MARK: - Button
                Button(action: {
                    shouldAnimate.toggle()
                    if shouldAnimate {
                        degree = 36000
                        rotateArm.toggle()
                        playSound(sound: "music", type: "m4a")
                    } else {
                        rotateArm.toggle()
                        degree = 0
                        audioPlayer?.stop()
                    }
                }) {
                    HStack(spacing: 8) {
                        if !shouldAnimate {
                            Text("Play")
                            Image(systemName: "play.circle.fill")
                                .imageScale(.large)
                        } else {
                            Text("Stop")
                            Image(systemName: "stop.fill")
                                .imageScale(.large)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .overlay(Capsule().stroke(lineWidth: 5).foregroundColor(.black))
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
