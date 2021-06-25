//
//  ConverstationCell.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI
import Kingfisher

struct ConverstationCell: View {
    let message: Message
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                KFImage(URL(string: message.user.profileImageUrl))
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .cornerRadius(28)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.user.fullname)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(message.text)
                        .font(.system(size: 15))
                        .lineLimit(2)
                }
                .frame(height: 64)
                .foregroundColor(.black)
                .padding(.trailing)
                
                Spacer()
            } //: HSTACK
            .padding(.horizontal, 10)
            
            Divider()
        } //: VSTACK
    }
}
