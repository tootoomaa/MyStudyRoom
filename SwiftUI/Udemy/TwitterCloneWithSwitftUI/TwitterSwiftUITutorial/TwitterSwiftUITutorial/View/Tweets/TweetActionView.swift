//
//  TweetActionView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/24.
//

import SwiftUI

struct TweetActionView: View {
    // MARK: - Properties
    let tweet: Tweet
    @ObservedObject var viewMode: TweetActionViewModel
    
    
    // MARK: - Init
    init(tweet: Tweet) {
        self.tweet = tweet
        self.viewMode = TweetActionViewModel(tweet: tweet)
    }
    
    // MARK: - Body
    var body: some View {
        // MARK: - Action Buttons
        HStack {
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "bubble.left")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "arrow.2.squarepath")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
            Spacer()
            
            Button(action: {
                viewMode.disLike ? viewMode.unlikeTweet() : viewMode.likeTweet()
            }, label: {
                Image(systemName: viewMode.disLike ? "heart.fill" : "heart")
                    .foregroundColor(viewMode.disLike ? .pink : .gray)
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "bookmark")
                    .font(.system(size: 16))
                    .frame(width: 32, height: 32)
            })
        } //: HSTACK Buttons
        .foregroundColor(.gray)
        .padding(.horizontal)
        
    }
}
