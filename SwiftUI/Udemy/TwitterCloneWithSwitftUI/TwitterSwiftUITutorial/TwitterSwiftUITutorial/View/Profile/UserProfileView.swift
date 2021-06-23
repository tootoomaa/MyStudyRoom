//
//  UserProfileView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/22.
//

import SwiftUI

struct UserProfileView: View {
    // MARK: - Properties
    let user: User
    @ObservedObject var viewMode: ProfileViewModel
    
    // MARK: - Init
    init(user: User) {
        self.user = user
        self.viewMode = ProfileViewModel(user: user)
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView(viewModel: viewMode,
                                  isFollowed: $viewMode.isFollowed)
                    .padding()
                
                ForEach(0..<9) { tweet in
                    TweetCell()
                }
                
            } //: VSTACK
            .navigationTitle("batman")
        } //: SCROLLVIEW
    }
}
