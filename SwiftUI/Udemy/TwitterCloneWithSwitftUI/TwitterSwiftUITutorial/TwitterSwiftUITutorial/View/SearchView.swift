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
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(0..<10) { _ in
                    
                    UserCell()
                        .padding(.leading)
                    
                }
            }
        } //: SCROLLVIEW
        .navigationBarTitle("Search")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
