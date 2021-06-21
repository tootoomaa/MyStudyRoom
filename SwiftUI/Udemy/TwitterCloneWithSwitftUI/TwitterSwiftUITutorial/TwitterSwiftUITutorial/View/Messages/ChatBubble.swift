//
//  ChatBubble.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct ChatBubble: Shape {
    // MARK: - Properties
    var isFromCurrnetUser: Bool
    
    // MARK: - PATH
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, isFromCurrnetUser ? . bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}

// MARK: - Preview
struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChatBubble(isFromCurrnetUser: true)
                .previewLayout(.fixed(width: 100, height: 60))
                .padding()
            
            ChatBubble(isFromCurrnetUser: false)
                .previewLayout(.fixed(width: 100, height: 60))
                .padding()
        }
    }
}
