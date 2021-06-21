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
                VStack {
                    ForEach(0..<15) { _ in
                        Text("Chat bubble")
                    }
                } //: VSTACK
            } //: SCROLLVIEW
            
            MessageInputView(messageText: $messageText)
                .padding()
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
