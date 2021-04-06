//
//  ImageOverlayView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/31.
//

import SwiftUI

struct ImageOverlayView: View {
    var body: some View {
        Image("wwdc")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
    }
}

struct ImageOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        ImageOverlayView()
    }
}
