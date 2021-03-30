//
//  HomeView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/30.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                
                NavigationLink("Pocketmon",
                               destination: PocketmonView())
                
                NavigationLink("Ruler",
                               destination: RulerView())
                
                NavigationLink("OutActivity",
                               destination : OutActivityView())
                    .navigationTitle("")
                
                NavigationLink("MovableButton",
                               destination: MovableButton())
                    .navigationTitle("")
                
                NavigationLink("DateListView",
                               destination: DateListView())
                    .navigationTitle("")
                
                NavigationLink("CircleProgressView",
                               destination: CircleProgressView())
                
            }
            .navigationBarTitle("Examples")
        }
        .accentColor(.black)
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .clear
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
