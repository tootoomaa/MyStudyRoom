//
//  FeedViewModel.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/24.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    // MARK: - Properties
    @Published var tweets = [Tweet]()
    
    
    // MARK: - Init
    init() {
        fetchTweets()
    }
    
    
    // MARK: - Fetch Tweets
    func fetchTweets() {
        COLLECTION_TWEETS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.tweets = documents.map{ Tweet(dictionary: $0.data()) }
        }
    }
    
}
