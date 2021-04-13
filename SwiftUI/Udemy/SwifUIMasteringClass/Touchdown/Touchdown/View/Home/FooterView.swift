//
//  FooterView.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("We offer the cutting edge, comfortable, lightwight and durable football helmets in the market at affordable prices")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .layoutPriority(2)
            
            Image("logo-lineal")
                .renderingMode(.template)
                .foregroundColor(.gray)
                .layoutPriority(0)
            
            Text("CopyRight Robert Petras\nAll reight reserved")
                .font(.footnote)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .layoutPriority(1)
        } //: VStack
        .padding()
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
            .previewLayout(.sizeThatFits)
            .background(colorBackgroud)
    }
}
