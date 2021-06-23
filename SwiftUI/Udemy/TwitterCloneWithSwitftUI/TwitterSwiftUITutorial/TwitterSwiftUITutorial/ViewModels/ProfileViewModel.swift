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
    let user: User
    @Published var isFollowed = false
    
    // MARK: - init
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
    }
    
    // MARK: - Follow
    func follow() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        let followersRef = COLLECTION_FOLLOWERS.document(user.id).collection("user-followers")
        
        // 현재 사용자(currnetUid)에 팔로우 한 사람(uid) 리스트에 추가
        followingRef.document(self.user.id).setData([:]) { _ in
            // 팔로우 당한 사람(uid)에 팔로우한 사람(currentUid)을 리스트에 등록
            followersRef.document(currentUid).setData([:]) { _ in
                self.isFollowed = true
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
                self.isFollowed = false
            }
        }
    }
    
    // MARK: - Check User is Followed
    func checkIfUserIsFollowed() {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let followingRef = COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
        followingRef.document(user.id).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else { return }
            self.isFollowed = isFollowed
        }
    }
}
