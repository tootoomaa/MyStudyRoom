//
//  MessageInputView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct MessageInputView: View {
    // MARK: - Properties
    @Binding var messageText: String
    let viewModel: CharViewModel
    
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack {
            TextField("message", text: $messageText)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(.gray)
                .frame(minHeight: 30)
            
            Button(action: {
                action
            }, label: {
                Text("Send")
            })
        }
    }
}

struct MessageInputView_Previews: PreviewProvider {
    static var previews: some View {
        MessageInputView(messageText: .constant("Message.."))
    }
}
