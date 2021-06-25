//
//  MessageView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI
import Kingfisher

// MARK: - MessageView
struct MessageView: View {
    
    
    // MARK: - Properties
    let message: Message
    
    
    // MARK: - Body
    var body: some View {
        HStack {
            if message.isFromCurrnetUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(ChatBubble(isFromCurrnetUser: message.isFromCurrnetUser))
                    .padding(.horizontal)
            } else {
                HStack(alignment: .bottom) {
                    KFImage(URL(string: message.user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text(message.text)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(.black)
                        .clipShape(ChatBubble(isFromCurrnetUser: message.isFromCurrnetUser))
                    
                }
                .padding(.horizontal)
                Spacer()
            } //: IF State
        }
        .padding()
    }
}

// MARK: - Prevew
//struct MessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageView(message: MOCK_MESSAGE[0])
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
