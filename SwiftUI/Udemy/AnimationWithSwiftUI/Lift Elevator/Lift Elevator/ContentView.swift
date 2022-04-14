//
//  ContentView.swift
//  Lift Elevator
//
//  Created by 김광수 on 2022/04/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Elevator()
    }
}

struct Elevator: View {
    @State private var doorsOpened = false
    @State private var floor1 = false
    @State private var floor2 = false
    @State private var animateSmily = false
    @State private var floorCountDirection = false
    
    @State var doorOpenTimer: Timer? = nil
    @State var chimesSoundTimer: Timer? = nil
    @State var doorsOpenCloseSoundTimer: Timer? = nil
    
    let backgroundColor = Color.black
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            // MARK: - SMILEY
            Image("smiley").resizable().aspectRatio(contentMode: .fit)
                .scaleEffect(animateSmily ? 1 : 0.01, anchor: .bottom)
                .animation(.easeInOut(duration: 2), value: animateSmily)
            
            // MARK: - FRAME AND DOORS
            FrameAndDoorsView(doorsOpened: $doorsOpened)
            
            // MARK: - Button
            HStack {
                Button {
                    stopTimer()
                    playDoorOpenCloseSound(interval: 0.5)
                    animateSmily.toggle()
                    withAnimation(.easeOut(duration: 2)) {
                        doorsOpened.toggle()
                    }
                    floorCountDirection.toggle()
                    floorNumbers()
//                    withAnimation(.easeInOut(duration: 2.0)) {
//                        doorsOpened.toggle()
//                    }
                } label: {
                    if !doorsOpened {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1))
                    } else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.black)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1))
                    }
                }
                .padding(5)
                .background(Color.black)
                .cornerRadius(30)
                
                Spacer()
            } //: HSTACK
            
            
            
            // MARK: - FLOW NUMBER
            VStack {
                HStack {
                    Image(systemName: "1.circle").foregroundColor(.black)
                        .opacity(floor1 ? 1 : 0.1)
                    
                    Image(systemName: "2.circle").foregroundColor(.black)
                        .opacity(floor2 ? 1 : 0.1)
                }
                Spacer()
            }
            .padding(3)
            
        } //: ZSTACK
    }
    
    func openDoors() {
        doorOpenTimer = Timer.scheduledTimer(withTimeInterval: 8, repeats: false) { _ in
            doorsOpened.toggle()
        }
    }
    
    func playChimeSound() {
        chimesSoundTimer = Timer.scheduledTimer(withTimeInterval: 5.5, repeats: false) { _ in
            playSound(sound: "elevatorChime", type: "m4a")
        }
    }
    
    func playDoorOpenCloseSound(interval: TimeInterval) {
        doorsOpenCloseSoundTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            playSound(sound: "doorOpenClose", type: "m4a")
        }
    }
    
    func stopTimer() {
        doorsOpenCloseSoundTimer?.invalidate()
        doorsOpenCloseSoundTimer = nil
        chimesSoundTimer?.invalidate()
        chimesSoundTimer = nil
        doorOpenTimer?.invalidate()
        doorOpenTimer = nil
    }
    
    func floorNumbers() {
        if !floor2 {
            floor1.toggle()
        }
        
        if !doorsOpened {
            animateSmily.toggle()
            openDoors()
            playChimeSound()
            
            // going up
            if floorCountDirection {
                withAnimation(.default.delay(4.0)) {
                    floor2 = true
                    floor1 = false
                }
                
                withAnimation(.default.delay(5.0)) {
                    floor1 = true
                    floor2 = false
                    playDoorOpenCloseSound(interval: 8.5)
                }
            } else if !floorCountDirection {
                // going down
                withAnimation(.default.delay(4.0)) {
                    floor1 = true
                    floor2 = false
                    playDoorOpenCloseSound(interval: 8.5)
                }
                
                withAnimation(.default.delay(5.0)) {
                    floor2 = true
                    floor1 = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView().previewDevice("iPhone 8")
        ContentView().previewDevice("iPhone 12").previewInterfaceOrientation(.portrait)
//        ContentView().previewDevice("iPad mini 6")
    }
}
