//
//  ChatView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct ChatView: View {
    // MARK: - Properties
    @State var messageText: String = ""
    
    
    // MARK: - Body
    var body: some View {
        VStack {
            ScrollView {
                // MARK: - Chat Message List View
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(MOCK_MESSAGE) { message in
                        MessageView(message: message) //: HSTACK
                    } //: FOREACH LOOP
                } //: VSTACK
            } //: SCROLLVIEW
            
            // MARK: - Message Input View
            MessageInputView(messageText: $messageText)
                .padding()
        }
    }
}

// MARK: - Preview
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
