//
//  ChatView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct ChatView: View {
    // MARK: - Properties
    let user: User
    @ObservedObject var viewModel: CharViewModel
    @State var messageText: String = ""
    
    // MARK: - Init
    init(user: User) {
        self.user = user
        self.viewModel = CharViewModel(user: user)
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            ScrollView {
                // MARK: - Chat Message List View
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.message) { message in
                        MessageView(message: message) //: HSTACK
                    } //: FOREACH LOOP
                } //: VSTACK
            } //: SCROLLVIEW
            
            // MARK: - Message Input View
            MessageInputView(messageText: $messageText, action: sendMessage)
                .padding()
        } //: VSTACK
        .navigationTitle(user.username)
    }
    
    func sendMessage() {        
        viewModel.sendMessage(messageText)
        messageText = ""
    }
}
//
//// MARK: - Preview
//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
