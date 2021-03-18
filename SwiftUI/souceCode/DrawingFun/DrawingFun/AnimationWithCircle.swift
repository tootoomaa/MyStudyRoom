//
//  ZeppyCodePage.swift
//  DrawingFun
//
//  Created by 김광수 on 2021/01/31.
//

import SwiftUI

struct AnimationWithCircle: View {
    
    var colors: [Color] = [.red, .blue, .green]
    
    @State var changeColor: Color = Color.yellow
    @State var multiplyer = 0.0
    
    var body: some View {
     
        VStack {
            ZStack {
                GragidentView()
                    .rotationEffect(.degrees(180) * multiplyer)
                    .animation(.linear(duration: 1))
                Circle()
                    .fill(changeColor)
                    .overlay(Circle().stroke(Color.black, lineWidth: 10))
                    .scaleEffect(CGSize(width: 1.0-multiplyer/10, height: 1.0-multiplyer/10))
            }
            ZStack {
                GragidentView()
                    .rotationEffect(.degrees(180) * multiplyer)
                    .animation(.easeOut)
                    .animation(.easeInOut(duration: 3))
                Circle()
                    .fill(changeColor)
                    .overlay(Circle().stroke(Color.black, lineWidth: 10))
                    .scaleEffect(CGSize(width: 1.0-multiplyer/10, height: 1.0-multiplyer/10))
            }
            ZStack {
                GragidentView()
                    .rotationEffect(.degrees(180) * multiplyer)
                    .animation(.spring(response: 0.2))
                Circle()
                    .fill(changeColor)
                    .overlay(Circle().stroke(Color.black, lineWidth: 10))
                    .scaleEffect(CGSize(width: 1.0-multiplyer/10, height: 1.0-multiplyer/10))
            }
            HStack {
                Button(action: {
                    
                    //                changeColor = colors.randomElement()!
                    self.multiplyer += 1
                    
                }, label: {
                    Text("Tap Button")
                })
                Button(action: {
                    
                    self.multiplyer = 0
                    
                }, label: {
                    Text("Inital size")
                })
            }
        }
        
    }
}

struct ZeppyCodePage_Previews: PreviewProvider {
    static var previews: some View {
        AnimationWithCircle()
    }
}
