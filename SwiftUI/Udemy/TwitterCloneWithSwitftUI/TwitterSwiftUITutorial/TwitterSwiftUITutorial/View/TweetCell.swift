//
//  TweetCell.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI
import Kingfisher

struct TweetCell: View {
    // MARK: - Properties
    let tweet: Tweet
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                
                // MARK: - Contents
                KFImage(URL(string: tweet.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 56, height: 56)
                    .cornerRadius(56/2)
                    .padding(.leading)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(tweet.fullname)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text("@\(tweet.username) -")
                            .foregroundColor(.gray)
                        
                        Text(tweet.timeStampString)
                            .foregroundColor(.gray)
                    } //: HSTACK
                    
                    Text(tweet.caption)
                        .foregroundColor(.black)
                } //: VSTACK
            }// :HSTACK
            .padding(.bottom)
            .padding(.trailing)
            
            // MARK: - Bottom Buttons
            TweetActionView(tweet: tweet)
            
            Divider()
            
        } //: VSTACK
    }
}
