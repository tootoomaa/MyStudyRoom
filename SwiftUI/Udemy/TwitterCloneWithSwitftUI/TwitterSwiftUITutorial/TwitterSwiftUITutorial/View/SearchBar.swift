//
//  SearchBar.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct SearchBar: View {
    // MARK: - Properties
    @Binding var text: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
        } //: HSTACK
        .padding(.horizontal, 10)
    }
}

// MARK: - Preview
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search..."))
    }
}