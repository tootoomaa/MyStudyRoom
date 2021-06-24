//
//  ProfileHeaderView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/22.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    // MARK: - Properties
    let viewModel: ProfileViewModel
    @Binding var isFollowed: Bool
    @State var selectedFilter: TweetFilterOptions = .tweets
    
    // MARK: - Body
    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 120, height: 120)
                .cornerRadius(120/2)
                .shadow(color: .black, radius: 6, x: 0.0, y: 0.0)
            
            Text(viewModel.user.fullname)
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 8)
            
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Billionaire by day, dar knight by night")
                .font(.system(size: 14))
                .padding(.top, 8)
            
            HStack(spacing: 40) {
                VStack {
                    Text("12")
                        .font(.system(size: 16).bold())
                    
                    Text("Followers")
                        .font(.footnote)
                        .foregroundColor(.gray)
                } //: Follower button
                
                VStack {
                    Text("12")
                        .font(.system(size: 16).bold())
                    
                    Text("Following")
                        .font(.footnote)
                        .foregroundColor(.gray)
                } //: Following Button
            } //: HStack
            .padding()
            
            ProfileActionButtonView(viewModel: viewModel, isFollowed: $isFollowed)
            
            Spacer()
        } //: VStack
    }
}
