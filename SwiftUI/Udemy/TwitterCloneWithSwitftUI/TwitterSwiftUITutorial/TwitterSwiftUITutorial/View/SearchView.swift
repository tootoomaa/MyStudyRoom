//
//  SearchView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct SearchView: View {
    // MARK: - Properties
    @State var searchText = ""
    @ObservedObject var viewModel = SearchViewModle(config: .search)
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(searchText.isEmpty
                            ? viewModel.users
                            : viewModel.filteredUsers(searchText)) { user in
                    NavigationLink(
                        destination: LazyView(UserProfileView(user: user)),
                        label: {
                            UserCell(user: user)
                        })
                } //: FOREACH
                .padding(.leading)
            } //: VSTACK
        } //: SCROLLVIEW
        .navigationBarTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
