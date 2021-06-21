//
//  ConverstationsView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct ConverstationsView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            ScrollView {
                VStack {
                    ForEach(0..<10) { _ in
                        ConverstationCell()
                    }
                } //: VSTACK
            } //: SCROLLVIEW
                        
            Button(action: {}, label: {
                Image(systemName: "envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
        }
    }
}

struct ConverstationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConverstationsView()
    }
}
