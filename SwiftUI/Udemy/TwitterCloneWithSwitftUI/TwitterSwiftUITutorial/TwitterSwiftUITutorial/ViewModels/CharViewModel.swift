//
//  CharViewModel.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/24.
//

import SwiftUI
import Firebase

class CharViewModel: ObservableObject {
    // MARK: - Properties
    let user: User          // 메시지 받을 사람의 정보
    @Published var message = [Message]()
    
    // MARK: - Init
    init(user: User) {
        self.user = user
        fetchMessage()
    }
    
    func fetchMessage() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_MESSAGE.document(uid).collection(user.id)
        query.order(by: "timestamp", descending: false)
        
        // 업데이트 되는 사항을 자동으로 변경해줌
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            
            changes.forEach { change in
                let messageData = change.document.data()
                guard let fromId = messageData["fromId"] as? String else { return }
                
                COLLECTION_USERS.document(fromId).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let user = User(dictionary: data)
                    self.message.append(Message(user: user, dictionary: messageData))
                    self.message.sort(by:{$0.timestamp.dateValue() > $1.timestamp.dateValue()})
                }//:
            }//: FOREACH
        }// addSNapshotListener
        
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
        
        print("DEBUG: \(data)")
        
    }
}
