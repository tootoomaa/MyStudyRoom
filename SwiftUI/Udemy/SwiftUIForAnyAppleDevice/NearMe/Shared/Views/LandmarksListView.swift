//
//  LandmarksListView.swift
//  NearMe (iOS)
//
//  Created by 김광수 on 2022/03/23.
//

import SwiftUI

struct LandmarksListView: View {
    
    let landmarks: [LandmarkViewModel]
    
    var body: some View {
        List(landmarks, id: \.id) { landmark in
            VStack(alignment: .leading, spacing: 10) {
                Text(landmark.name)
                    .font(.headline)
                Text(landmark.title)
            }
        }
        .listStyle(PlainListStyle())
    }
}

//struct LandmarksListView_Previews: PreviewProvider {
//    static var previews: some View {
//        LandmarksListView()
//    }
//}
