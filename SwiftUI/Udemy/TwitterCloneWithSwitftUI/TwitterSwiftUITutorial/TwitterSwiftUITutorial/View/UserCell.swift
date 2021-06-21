//
//  UserCell.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct UserCell: View {
    // MARK: - Body
    var body: some View {
        HStack {
            
            Image("venom-10")
                .resizable()
                .scaledToFit()
                .clipped()
                .frame(width: 56, height: 56)
                .cornerRadius(28)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("venom")
                    .font(.system(size: 14, weight: .semibold))
                Text("Eddie Brock")
                    .font(.system(size: 14))
            } //: VSTACK
            
            Spacer()
        } //: HSTACK
        .foregroundColor(.black)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
    }
}
