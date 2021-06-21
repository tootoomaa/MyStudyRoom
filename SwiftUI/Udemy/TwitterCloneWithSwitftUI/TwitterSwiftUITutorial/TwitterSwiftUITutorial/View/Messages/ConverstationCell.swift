//
//  ConverstationCell.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct ConverstationCell: View {
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Image("venom-10")
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .cornerRadius(28)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("venom")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Longer message text to see what happend when i do thsit")
                        .font(.system(size: 15))
                        .lineLimit(2)
                }
                .frame(height: 64)
                .foregroundColor(.black)
                .padding(.trailing)
            } //: HSTACK
            Divider()
        } //: VSTACK
    }
}

struct ConverstationCell_Previews: PreviewProvider {
    static var previews: some View {
        ConverstationCell()
    }
}
