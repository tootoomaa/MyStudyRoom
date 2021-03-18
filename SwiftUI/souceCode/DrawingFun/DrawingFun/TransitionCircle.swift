//
//  TransitionCircle.swift
//  DrawingFun
//
//  Created by 김광수 on 2021/01/31.
//

import SwiftUI

struct TransitionCircle: View {
    
    @State var show = false
    
    var body: some View {
        VStack {
            Circle()
            if show {
                KKSCode().transition(.scale)
            }
            Circle()
            Button(action: {
                
                withAnimation{
                    self.show.toggle()
                }
                
            }, label: {
                Text("Button")
            })
        }
        
        
    }
}

struct TransitionCircle_Previews: PreviewProvider {
    static var previews: some View {
        TransitionCircle()
    }
}
