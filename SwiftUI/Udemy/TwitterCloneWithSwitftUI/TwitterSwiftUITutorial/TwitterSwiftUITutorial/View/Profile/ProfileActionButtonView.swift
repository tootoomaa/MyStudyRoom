//
//  ProfileActionButtonView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/22.
//

import SwiftUI

struct ProfileActionButtonView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: ProfileViewModel
    
    // MARK: - Body
    var body: some View {
        if viewModel.user.isCurrnetUser {
            Button(action: {
                print("DEBUG: Follow here")
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
                    viewModel.user.isFollowed ? viewModel.unfollow() : viewModel.follow()
                }, label: {
                    Text(viewModel.user.isFollowed ? "Following" : "Follow")
                        .frame(width: 180, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                })
                .cornerRadius(20)
                
                NavigationLink(
                    destination: ChatView(user: viewModel.user),
                    label: {
                        Text("Message")
                            .frame(width: 180, height: 40)
                            .background(Color.purple)
                            .foregroundColor(.white)
                    }
                ) //: Navigation Link
                .cornerRadius(20)
            }
        }
        
    }
}
