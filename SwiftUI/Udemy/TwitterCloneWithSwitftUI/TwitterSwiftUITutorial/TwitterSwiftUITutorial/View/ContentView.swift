//
//  ContentView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/15.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    // MARK: - Propeties
    @State var index: Int = 0
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    // MARK: - Body
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainView()
            } else {
                LoginView()
            }
        } //: Group
    }
    
    // MARK: - Main View
    fileprivate func MainView() -> some View {
        NavigationView {
            TabView(selection: $index) {
                FeedView()
                    .onTapGesture { self.index = 0 }
                    .tabItem { Image(systemName: "house") }
                    .tag(0)
                
                SearchView()
                    .onTapGesture { self.index = 1 }
                    .tabItem { Image(systemName: "magnifyingglass") }
                    .tag(1)
                
                ConverstationsView()
                    .onTapGesture { self.index = 2 }
                    .tabItem { Image(systemName: "envelope") }
                    .tag(2)
            }
            .navigationBarTitle(viewModel.getNaviTitle(forIndex: index))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                viewModel.signOut()
            }, label: {
                if let user = viewModel.user {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 32, height: 32)
                        .cornerRadius(16)
                }
            }))
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
