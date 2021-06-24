//
//  ProfileViewModel.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/23.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    // MARK: - Properties
    @Published var user: User
    @Published var userTweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    
    // MARK: - init
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
        fetchUserTweets()           // 사용자 트윗
        fetchLikedTweets()          // 사용자가 좋아요한 트윗
        fetchUserStats()
    }
    
}

extension ProfileViewModel {
    // MARK: - Follow
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        
        // 현재 사용자(currnetUid)에 팔로우 한 사람(uid) 리스트에 추가
        followingRef.document(self.user.id).setData([:]) { _ in
            // 팔로우 당한 사람(uid)에 팔로우한 사람(currentUid)을 리스트에 등록
            followersRef.document(currentUid).setData([:]) { _ in
                self.user.isFollowed = true
            }
        }
    }
    
    // MARK: - Un follow
    func unfollow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        
        followingRef.document(user.id).delete { _ in
            followersRef.document(currentUid).delete { _ in
                self.user.isFollowed = false
            }
        }
    }
    
    // MARK: - Fetch user stats
    func fetchUserStats() {
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        let followingRef = COLLECTION_FOLLOWING.document(user.id).collection("user-following")
        
        followersRef.getDocuments { snapshot, _ in
            guard let followerCount = snapshot?.documents.count else { return }
            
            followingRef.getDocuments { snapshot, _ in
                guard let followingCount = snapshot?.documents.count else { return }
                
                self.user.stats = UserStats(followers: followerCount, following: followingCount)
                
            } //: folloingRef
        } //: followerRef
    }
}
 
extension ProfileViewModel {
    // MARK: - Check User is Followed
    func checkIfUserIsFollowed() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard !user.isCurrnetUser else { return }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        
        followingRef.document(user.id).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else { return }
            self.user.isFollowed = isFollowed
        }
    }
    
    // MARK: - Fetch user Tweets
    func fetchUserTweets() {
        COLLECTION_TWEETS.whereField("uid", isEqualTo: user.id).getDocuments() { snaphost, _ in
            guard let documents = snaphost?.documents else { return }
            self.userTweets = documents.map { Tweet(dictionary: $0.data()) }
        }
    }
    
    // MARK: - Fetch user like Tweets
    func fetchLikedTweets() {
        var tweets = [Tweet]()
        
        COLLECTION_USERS.document(user.id).collection("user-likes").getDocuments { snaphost, error in
            guard let documents = snaphost?.documents else { return }
            
            let tweetIDs = documents.map{$0.documentID}
            tweetIDs.forEach { id in
                COLLECTION_TWEETS.document(id).getDocument { snaphost, error in
                    guard let data = snaphost?.data() else { return }
                    let tweet = Tweet(dictionary: data)
                    tweets.append(tweet)
                    
                    guard tweets.count == tweetIDs.count else { return }
                    self.likedTweets = tweets       // 한번에 적용
                }
            }
        }
    }
    
    // MARK: - filtered tweets
    func tweets(forFilter filter: TweetFilterOptions) -> [Tweet] {
        switch filter {
        case .tweets:   return self.userTweets
        case .likes:    return self.likedTweets
        }
    }
}
