//
//  HeaderView.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/24.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - Properties
    @State private var showHeadline: Bool = false
    
    var header: Header
    
    var slideInAnimation: Animation {
        Animation.spring(response: 1.5, dampingFraction: 0.5, blendDuration: 0.5)
            .speed(1)
            .delay(0.25)
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Image(header.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
            HStack(alignment: .top, spacing: 0) {
                Rectangle()
                    .fill(Color("ColorGreenLight"))
                    .frame(width: 4)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(header.headline)
                        .font(.system(.title, design: .serif))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .shadow(radius: 3)
                    
                    Text(header.subheadline)
                } //; VSTACK
                .padding(.vertical, 0)
                .padding(.horizontal, 20)
                .frame(width: 281, height: 105)
                .background(Color("ColorBlackTransparentLight"))
            } //: HSTACK
            .frame(width: 285, height: 105, alignment: .center)
            .offset(x: -66, y: showHeadline ? 75 : 220)
            .animation(slideInAnimation)
            .onAppear {
                showHeadline.toggle()
            }
        } //: ZSTACK
        .frame(width: 480, height: 320, alignment: .center)
    }
}
// MARK: - Preivew
struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(header: headersData[0])
                .previewLayout(.sizeThatFits)
            
            HeaderView(header: headersData[0])
                .previewLayout(.sizeThatFits)
                .environment(\.colorScheme, .dark)
        }
    }
}
