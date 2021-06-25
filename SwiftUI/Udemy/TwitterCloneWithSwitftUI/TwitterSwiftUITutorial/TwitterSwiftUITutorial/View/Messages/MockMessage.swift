//
//  MockMessage.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI
import Firebase

struct Message: Identifiable {
    let text: String
    let user: User
    let toId: String
    let fromId: String
    let isFromCurrnetUser: Bool
    let timestamp: Timestamp
    let id: String
    
    var chatPartnerId: String { return isFromCurrnetUser ? toId : fromId }
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        
        self.isFromCurrnetUser = fromId == Auth.auth().currentUser?.uid
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.id = dictionary["id"] as? String ?? ""
    }
}

struct MockMessage: Identifiable {
    let id: Int
    let imageName: String
    let messageText: String
    let isCurrentUser: Bool
}

let MOCK_MESSAGE: [MockMessage] = [
    .init(id: 0, imageName: "spiderman", messageText: "Hey What's up", isCurrentUser: false),
    .init(id: 1, imageName: "batman", messageText: "Not much, you?", isCurrentUser: true),
    .init(id: 2, imageName: "batman", messageText: "How's you day?", isCurrentUser: true),
    .init(id: 3, imageName: "spiderman", messageText: "It is pretty good!", isCurrentUser: false),
    .init(id: 4, imageName: "spiderman", messageText: "Hey What's up", isCurrentUser: false),
    .init(id: 5, imageName: "batman", messageText: "Sad!!!!?", isCurrentUser: true)
]
