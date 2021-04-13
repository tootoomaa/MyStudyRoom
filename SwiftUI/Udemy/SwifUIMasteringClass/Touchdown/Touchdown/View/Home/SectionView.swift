//
//  SectionView.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

struct SectionView: View {
    // MARK: - Properties
    @State var rotateClockwise: Bool
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Text("Categories".uppercased())
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .rotationEffect(Angle(degrees: rotateClockwise ? 90 : -90))
            
            Spacer()
        }//: VSTACK
        .background(colorGray.cornerRadius(12))
        .frame(width: 85)
    }
}

// MARK: - Preview
struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SectionView(rotateClockwise: false)
                .previewLayout(.fixed(width: 120, height: 240))
                .padding()
                .background(colorBackgroud)
            
            SectionView(rotateClockwise: true)
                .previewLayout(.fixed(width: 120, height: 240))
                .padding()
                .background(colorBackgroud)
        }
    }
}
