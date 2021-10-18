//
//  HikingDetailView.swift
//  Hiking
//
//  Created by 김광수 on 2021/10/11.
//

import SwiftUI

struct HikingDetail: View {
    // MARK: - Properties
    let hike: Hike
    @State private var zommd: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image(hike.imageURL)
                .resizable()
                .aspectRatio(contentMode: self.zommd ? .fill : .fit)
                .onTapGesture {
                    withAnimation {
                        self.zommd.toggle()
                    }
                }
            
            Text(hike.name)
            Text(String(format: "%.2f", hike.miles))
        }//: VSTACK
        .navigationBarTitle(hike.name, displayMode: .inline)
    }
}

struct HikingDetail_Previews: PreviewProvider {
    static var previews: some View {
        HikingDetail(hike: Hike(name: "Angle Langind", imageURL: "2", miles: 10.3))
    }
}
