//
//  UploadTweetViewModel.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/24.
//

import SwiftUI
import Firebase

class UploadTweetViewModel: ObservableObject {
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    // MARK: - Uplaod Tweet
    func uploadTweet(caption: String) {
//        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let user = AuthViewModel.shared.user else { return }
        
        let docRef = COLLECTION_TWEETS.document()
        
        let data: [String: Any] = ["uid": user.id,
                                   "caption": caption,
                                   "fullname": user.fullname,
                                   "timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "profileImageUrl": user.profileImageUrl,
                                   "likes": 0,
                                   "id": docRef.documentID]
        
        docRef.setData(data) { _ in
            print("DEBUG: Successfully uploaded tweet...")
            self.isPresented = false
        }
    }
    
//    func uploadTweet(caption: String, completion: @escaping ((Error?) -> Void)) {
////        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//        guard let user = AuthViewModel.shared.user else { return }
//
//        let docRef = COLLECTION_TWEETS.document()
//
//        let data: [String: Any] = ["uid": user.id,
//                                   "caption": caption,
//                                   "fullname": user.fullname,
//                                   "timestamp": Timestamp(date: Date()),
//                                   "username": user.username,
//                                   "profileImageUrl": user.profileImageUrl,
//                                   "likes": 0,
//                                   "id": docRef.documentID]
//
//        docRef.setData(data, completion: completion)
//    }
}
