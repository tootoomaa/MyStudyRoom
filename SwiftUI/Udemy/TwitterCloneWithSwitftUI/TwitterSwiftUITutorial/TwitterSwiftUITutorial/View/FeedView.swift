//
//  FeedView.swift
//  TwitterSwiftUITutorial
//
//  Created by Stephen Dowless on 11/15/20.
//

import SwiftUI

struct FeedView: View {
    // MARK: - Properties
    @State var isShowingNewTweetView = false
    

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack {
                    ForEach(0..<19) { _ in
                        TweetCell()
                    }
                } //: VSTACK
                .padding()
            } //: SCROLLVIEW
            
            Button(action: { isShowingNewTweetView.toggle() }, label: {
                Image("tweet")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 28, height: 28)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $isShowingNewTweetView) {
                NewTweetView(isPresented: $isShowingNewTweetView)
            }
        } //: ZSTACK
    }
}

// MARK: - Preview
struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
