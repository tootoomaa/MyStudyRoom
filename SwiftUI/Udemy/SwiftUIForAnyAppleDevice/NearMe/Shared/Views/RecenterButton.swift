//
//  RecenterButton.swift
//  NearMe (iOS)
//
//  Created by 김광수 on 2022/03/23.
//

import SwiftUI

struct RecenterButton: View {
    
    let onTapped: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                onTapped()
            } label: {
                Label("Re-Center", systemImage: "triangle")
            }.padding(10)
                .foregroundColor(.white)
                .background(Color.cyan)
                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        }
        
    }
}

struct RecenterButton_Previews: PreviewProvider {
    static var previews: some View {
        RecenterButton { }
    }
}
