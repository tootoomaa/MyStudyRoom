//
//  ContentView.swift
//  AddView
//
//  Created by 김광수 on 2022/04/11.
//

import SwiftUI

struct ContentView: View {
    
    @State var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack {
                ExpandingView(expand: $isAnimating, direction: .bottom, symbolName: "note.text")
                ExpandingView(expand: $isAnimating, direction: .left, symbolName: "doc")
                ExpandingView(expand: $isAnimating, direction: .right, symbolName: "photo")
                ExpandingView(expand: $isAnimating, direction: .top, symbolName: "mic.fill")
                
                Image(systemName: "plus").font(.system(size: 40, weight: isAnimating ? .regular : .semibold, design: .rounded))
                    .foregroundColor(isAnimating ? Color.white : Color.black)
                    .rotationEffect(isAnimating ? .degrees(45) : .degrees(0))
                    .scaleEffect(isAnimating ? 3 : 1)
                    .opacity(isAnimating ? 0.5 : 1)
                    .animation(.spring(response: 0.35, dampingFraction: 0.85, blendDuration: 1), value: isAnimating)
            }
            .onTapGesture {
                self.isAnimating.toggle()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
