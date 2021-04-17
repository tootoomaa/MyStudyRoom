//
//  BlankView.swift
//  Devote
//
//  Created by 김광수 on 2021/04/17.
//

import SwiftUI

struct BlankView: View {
    // MARK: - Properties
    
    var backgroundColor: Color
    var bacgroundOpacity: Double
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(bacgroundOpacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: Color.black, bacgroundOpacity: 0.3)
            .background(BackgroundImageView())                  // 블러 뷰 테스트를 위한 배경 설정
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}
