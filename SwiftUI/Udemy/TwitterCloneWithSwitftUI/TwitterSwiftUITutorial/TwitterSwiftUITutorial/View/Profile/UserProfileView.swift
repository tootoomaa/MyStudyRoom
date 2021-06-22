//
//  UserProfileView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/22.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        ScrollView {
            VStack {
                ProfileHeaderView()
                    .padding()
                
                FilterButtonView(selectedOption: .constant(.tweets))
                    .padding()
                
                ForEach(0..<9) { tweet in
                    TweetCell()
                }
                
            } //: VSTACK
            .navigationTitle("batman")
        } //: SCROLLVIEW
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserProfileView()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
