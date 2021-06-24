//
//  CharViewModel.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/24.
//

import SwiftUI
import Firebase

struct CharViewModel {
    let user: User          // 메시지 받을 사람의 정보
    
    init(user: User) {
        self.user = user
    }
    
    func fetchMessage() {
        
    }
    
    /*
     1.메시지는 각각의 유저별로 가지고 있어야한다.
     - 서로 다른 사람의 메시지랑 isCurrnetUser
     */
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        let currentUserRef = COLLECTION_MESSAGE.document(currentUid).collection(user.id).document()
        let currentRecentRef = COLLECTION_MESSAGE.document(currentUid).collection("recent-messages")
        
        let receiveUserRef = COLLECTION_MESSAGE.document(user.id).collection(currentUid)
        let receivingRecnetRef = COLLECTION_MESSAGE.document(user.id).collection("recent-messages")
        
        let messageID = currentUserRef.documentID
        
        let data: [String: Any] = ["text": messageText,
                                   "id": messageID,
                                   "fromId": currentUid,
                                   "toid": user.id,
                                   "timestamp": Timestamp(date: Date())]
        
        currentUserRef.setData(data)
        receiveUserRef.document(messageID).setData(data)
        
        currentRecentRef.document(user.id).setData(data)
        receivingRecnetRef.document(currentUid).setData(data)
    }
}
