//
//  CreditsView.swift
//  Africa
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack {
            Image("compass")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            
            Text("""
                CopyRight- kimkwagnsoo
                All right Reserved
                Better App less code
                """)
                .font(.footnote)
                .multilineTextAlignment(.center)
        }//: VSTack
        .padding()
        .opacity(0.4)
    
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
