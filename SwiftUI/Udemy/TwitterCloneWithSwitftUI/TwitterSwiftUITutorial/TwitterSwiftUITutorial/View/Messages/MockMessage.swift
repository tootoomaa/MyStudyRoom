//
//  MockMessage.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import Foundation

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
