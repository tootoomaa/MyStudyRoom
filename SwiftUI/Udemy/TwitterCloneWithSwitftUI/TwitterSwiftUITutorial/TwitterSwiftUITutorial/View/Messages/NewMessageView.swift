//
//  NewMessageView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/21.
//

import SwiftUI

struct NewMessageView: View {
    // MARK: - Properties
    @State var searchText = ""
    @Binding var show: Bool
    @Binding var startChar: Bool
    @ObservedObject var viewModel = SearchViewModle()
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(viewModel.users) { user in
                    
                    Button(action: {
                        self.show.toggle()
                        self.startChar.toggle()
                    }, label: {
                        UserCell(user: user)
                    })
                } //: FOREACH
                .padding(.leading)
            } //: VSTACK
        } //: SCROLLVIEW
        .navigationBarTitle("Search")
    }
}

// MARK: - Preview
struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(show: .constant(true), startChar: .constant(true))
    }
}
