//
//  FrameAndDoorsView.swift
//  Lift Elevator
//
//  Created by 김광수 on 2022/04/05.
//

import SwiftUI

struct FrameAndDoorsView: View {
    
    @Binding var doorsOpened: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                HStack {
                    Image("leftDoor").resizable()
                        .frame(maxWidth: geo.size.width)
                        .offset(x: doorsOpened ? -geo.size.width / 2 : 4)
                    
                    Image("rightDoor").resizable()
                        .frame(maxWidth: geo.size.width)
                        .offset(x: doorsOpened ? geo.size.width / 2 : -4)
                    
                } //: HStack
                
                Image("doorFrame").resizable()
                    .frame(maxWidth: geo.size.width,
                           maxHeight: geo.size.height)
            } //: GeometryReader
        } //: ZStack
    }
}

struct FrameAndDoorsView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            FrameAndDoorsView(doorsOpened: .constant(false))
            
            FrameAndDoorsView(doorsOpened: .constant(true))
        }
    }
}
