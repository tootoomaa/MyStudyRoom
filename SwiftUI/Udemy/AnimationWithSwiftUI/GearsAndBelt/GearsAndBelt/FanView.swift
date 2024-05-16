//
//  FanView.swift
//  GearsAndBelt
//
//  Created by 김광수 on 2022/04/11.
//

import SwiftUI

struct FanView: View {
    
    var degree: Double = 360 * 4
    @State private var rotateFan = false
    
    var body: some View {
        ZStack {
            Image("fan").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .rotationEffect(
                    .degrees(rotateFan ? degree : 0), anchor: .center
                )
                .animation(
                    .linear(duration: 4).repeatForever(autoreverses: false),
                    value: rotateFan
                )
                .onAppear {
                    rotateFan.toggle()
                }.shadow(color: .black, radius: 1)
        }
    }
}

struct FanView_Previews: PreviewProvider {
    static var previews: some View {
        FanView()
    }
}
