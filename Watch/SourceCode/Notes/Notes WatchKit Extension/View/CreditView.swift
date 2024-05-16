//
//  CreditView.swift
//  Notes WatchKit Extension
//
//  Created by 김광수 on 2022/09/02.
//

import SwiftUI

struct CreditView: View {
    var body: some View {
        VStack {
            Image("developer-no3")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            NoteWithLineView(title: "CREDITS")
            
            Text("Robert Petras")
                .foregroundColor(.white)
                .font(.subheadline)
            
            Text("Developer")
                .foregroundColor(.gray)
                .opacity(0.4)
                .font(.caption2)
        } //: VSTACK
    }
}

struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}
