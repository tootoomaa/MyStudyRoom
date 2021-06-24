//
//  TweetActionViewModel.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/24.
//

import SwiftUI

class TweetActionViewModel: ObservableObject {
    // MARK: - Properties
    let tweet: Tweet
    @Published var disLike = false
    /*
     1. 트윗 데이터 내부
        1-1. 좋아요 + 1
        2-2. 리트윗 + tweet.id
     2. 사용자 내부
        2-1. 좋아요 + tweet.id
        2-2. 리트윗 + tweet.id
     */
    // MARK: - Init
    init(tweet: Tweet) {
        self.tweet = tweet
        checkIfUserLikedTweet()
    }
    
    
    // MARK: - Like Tweet
    func likeTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let tweetRef = COLLECTION_TWEETS.document(tweet.id)
        let userLikesRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        tweetRef.updateData(["likes": tweet.likes + 1]) { _ in
            tweetRef.collection("tweet-likes").document(uid).setData([:]) { _ in
                userLikesRef.document(self.tweet.id).setData([:]) { _ in
                    self.disLike = true
                } //: User data Save
            } //: Tweet data Save
        } //: Tweet like += 1
    }
    
    // MARK: - Un Like Tweet
    func unlikeTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let tweetRef = COLLECTION_TWEETS.document(tweet.id)
        let userRef = COLLECTION_USERS.document(uid).collection("user-likes")
        
        tweetRef.updateData(["likes": tweet.likes - 1]) { _ in
            userRef.document(uid).delete { _ in
                userRef.document(self.tweet.id).delete { _ in
                    self.disLike = false
                } //: User data Save
            } //: Tweet data Save
        } //: Tweet like -= 1
    }
    
    // MARK: - Check Tweet is Liked
    func checkIfUserLikedTweet() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let userRef = COLLECTION_USERS.document(uid).collection("user-likes").document(tweet.id)
        
        userRef.getDocument { snapshot, _ in
            guard let dislike = snapshot?.exists else { return }
            self.disLike = dislike
        }
    }

}
