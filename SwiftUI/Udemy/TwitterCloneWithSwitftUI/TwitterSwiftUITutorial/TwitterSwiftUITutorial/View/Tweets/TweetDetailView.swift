//
//  TweetDetailView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/24.
//

import SwiftUI
import Kingfisher

struct TweetDetailView: View {
    // MARK: - Propeties
    let tweet: Tweet
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                KFImage(URL(string: tweet.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .cornerRadius(28)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(tweet.fullname)
                        .font(.system(size: 15, weight: .semibold))
                    
                    Text("@\(tweet.username)")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                } //: inner VSTACK
                
            } //: HSTACK
            
            Text(tweet.caption)
                .font(.system(size: 22))
            
            Text(tweet.detailTimestampString)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Divider()
            
            HStack(spacing: 12) {
                
                HStack(spacing: 4) {
                    Text("0")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Retweets")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                HStack(spacing: 4) {
                    Text("\(tweet.likes)")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text("Likes")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
            }
            
            Divider()
            
            TweetActionView(tweet: tweet)
            
            Spacer()
            
        } //: VSTACK
        .padding()
    }
}
