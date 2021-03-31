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
            VStack {
                VStack {
                    List {
                        NavigationLink("Pocketmon", destination: PocketmonView())
                        NavigationLink("Ruler", destination: RulerView())
                        NavigationLink("OutActivity", destination : OutActivityView())
                        NavigationLink("MovableButton",destination: MovableButton()).navigationTitle("")
                        NavigationLink("DateListView",destination: DateListView())
                        NavigationLink("CircleProgressView",destination: CircleProgressView())
                        NavigationLink("CollectionView",destination: CollectionView())
                        NavigationLink("TimerView",destination: TimerView())
                        NavigationLink("InfomationBlurView",destination: InformationBlurView())
                        NavigationLink("FaceAnchorView",destination: FaceAnchorView())
                    }
                }
                VStack {
                    List {
                        NavigationLink("ImageOverlayView",destination: ImageOverlayView())
                    }
                }
                .navigationBarTitle("Examples")
            }
        }
        .accentColor(.black)
        .onAppear {
            UINavigationBar.appearance().backgroundColor = .clear
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
        }
    }
}
