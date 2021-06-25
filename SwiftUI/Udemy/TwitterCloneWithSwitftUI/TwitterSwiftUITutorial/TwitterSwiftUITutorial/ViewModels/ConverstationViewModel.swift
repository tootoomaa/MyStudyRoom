//
//  ConverstationViewModel.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/25.
//

import SwiftUI

class ConverstationViewModel: ObservableObject {
    // MARK: - Properties
    @Published var recentMessages = [Message]()
    private var recentMessagesDictionary = [String: Message]() // key : user
    
    
    // MARK: - Init
    init() {
        fetchRecentMessages()
    }
    
    
    func fetchRecentMessages() {
        
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_MESSAGE.document(uid).collection("recent-messages")
        query.order(by: "timestamp", descending: true)
        
        // 업데이트 되는 사항을 자동으로 변경해줌
        query.addSnapshotListener { snapshot, error in
            guard let changes = snapshot?.documentChanges else { return }
            
            changes.forEach { change in
                let messageData = change.document.data()
                let uid = change.document.documentID
                
                COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let user = User(dictionary: data)
                    
                    self.recentMessagesDictionary[uid] = Message(user: user, dictionary: messageData)
                    self.recentMessages.append(Message(user: user, dictionary: messageData))
                    self.recentMessages = Array(self.recentMessagesDictionary.values)
                }//:
            }//: FOREACH
        }// addSNapshotListener
        
    }
    
}
