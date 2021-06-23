//
//  ContentView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/15.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Propeties
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
            TabView {
                FeedView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                
                ConverstationsView()
                    .tabItem {
                        Image(systemName: "envelope")
                        Text("Message")
                    }
            }
            .navigationBarTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
