//
//  MessageView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

// MARK: - MessageView
struct MessageView: View {
    
    
    // MARK: - Properties
    let message: MockMessage
    
    
    // MARK: - Body
    var body: some View {
        HStack {
            if message.isCurrentUser {
                Spacer()
                Text(message.messageText)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromCurrnetUser: message.isCurrentUser))
                    .padding(.horizontal)
            } else {
                HStack(alignment: .bottom) {
                    Image(message.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text(message.messageText)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .clipShape(ChatBubble(isFromCurrnetUser: message.isCurrentUser))
                    
                }
                .padding(.horizontal)
                Spacer()
            } //: IF State
        }
    }
}

// MARK: - Prevew
struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: MOCK_MESSAGE[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
