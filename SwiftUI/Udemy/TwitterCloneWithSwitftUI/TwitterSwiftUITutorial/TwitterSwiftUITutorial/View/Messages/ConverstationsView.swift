//
//  ConverstationsView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct ConverstationsView: View {
    // MARK: - Properties
    @State var isShowingNewMessageView = false
    @State var startChat: Bool = false
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            NavigationLink(
                destination: ChatView(),
                isActive: $startChat,
                label: {})
            
            ScrollView {
                VStack {
                    ForEach(0..<10) { _ in
                        NavigationLink(
                            destination: ChatView(),
                            label: {
                                ConverstationCell()
                            })
                    } //: FOREACH LOOP
                } //: VSTACK
            } //: SCROLLVIEW
                        
            Button(action: { self.isShowingNewMessageView.toggle() },
                   label: {
                    Image(systemName: "envelope")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .padding()
                   })
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .sheet(isPresented: $isShowingNewMessageView, content: {
                    NewMessageView(show: $isShowingNewMessageView, startChar: $startChat)
                })
        } //: ZSTACK
    }
}

struct ConverstationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConverstationsView()
    }
}
