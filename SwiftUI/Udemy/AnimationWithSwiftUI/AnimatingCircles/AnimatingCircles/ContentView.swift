//
//  ContentView.swift
//  AnimatingCircles
//
//  Created by 김광수 on 2022/03/17.
//

import SwiftUI

struct ContentView: View {
    
    let timer = DispatchSource.makeTimerSource()
    @State var animator: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.green.opacity(0.5))
            
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.green.opacity(0.5))
            
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.green.opacity(0.5))
            
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.green.opacity(0.5))
            
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.green.opacity(0.5))
            
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.green.opacity(0.5))
        }
        .onAppear {
            timer.schedule(deadline: .now())
            timer.setEventHandler {
                self.animator.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
