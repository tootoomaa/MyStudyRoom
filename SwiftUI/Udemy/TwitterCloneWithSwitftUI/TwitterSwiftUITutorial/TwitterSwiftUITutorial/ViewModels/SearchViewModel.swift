//
//  SearchViewModel.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/23.
//

import SwiftUI
import Firebase

class SearchViewModle: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUsers()
    }
    
    // MARK: - Fetch Users
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.map({ User(dictionary: $0.data()) })
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercaseQuery = query.lowercased()
        return self.users.filter({ $0.fullname.lowercased().contains(lowercaseQuery)
                                    || $0.username.lowercased().contains(lowercaseQuery) })
    }
    
}
