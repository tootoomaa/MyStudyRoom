//
//  SearchViewModel.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/23.
//

import SwiftUI
import Firebase

enum SearchViewModelConfigurration {
    case search
    case newMessage
}

class SearchViewModle: ObservableObject {
    @Published var users = [User]()
    private let config: SearchViewModelConfigurration
    
    init(config: SearchViewModelConfigurration) {
        self.config = config
        fetchUsers(forconfig: config)
    }
    
    // MARK: - Fetch Users
    func fetchUsers(forconfig config: SearchViewModelConfigurration) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            let users = documents.map({ User(dictionary: $0.data()) })
            
            switch config {
            case .newMessage:
                self.users = users.filter({ !$0.isCurrnetUser })
            case .search:
                self.users = users
            }
            
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercaseQuery = query.lowercased()
        return self.users.filter({ $0.fullname.lowercased().contains(lowercaseQuery)
                                    || $0.username.lowercased().contains(lowercaseQuery) })
    }
    
}
