//
//  ProfileActionButtonView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/22.
//

import SwiftUI

struct ProfileActionButtonView: View {
    // MARK: - Properties
    let isCurrentUser: Bool
    
    // MARK: - Body
    var body: some View {
        if isCurrentUser {
            Button(action: {
                
            }, label: {
                Text("Edit Profile")
                    .frame(width: 360, height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
            })
            .cornerRadius(20)
        } else {
            HStack {
                Button(action: {
                    
                }, label: {
                    Text("Follow")
                        .frame(width: 180, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                })
                .cornerRadius(20)
                
                Button(action: {
                    
                }, label: {
                    Text("Message")
                        .frame(width: 180, height: 40)
                        .background(Color.purple)
                        .foregroundColor(.white)
                })
                .cornerRadius(20)
            }
        }
         
    }
}

struct ProfileActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionButtonView(isCurrentUser: false)
            .previewLayout(.sizeThatFits)
        
        ProfileActionButtonView(isCurrentUser: true)
            .previewLayout(.sizeThatFits)
    }
}
