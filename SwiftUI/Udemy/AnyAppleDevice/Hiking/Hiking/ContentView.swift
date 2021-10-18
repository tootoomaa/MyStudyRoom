//
//  ContentView.swift
//  Hiking
//
//  Created by 김광수 on 2021/10/11.
//

import SwiftUI

// MARK: - content View
struct ContentView: View {
    
    let hikes = Hike.all()
    
    var body: some View {
        NavigationView {
            
            List(self.hikes, id: \.name) { hike in
                NavigationLink(
                    destination: HikingDetail(hike: hike),
                    label: { HikeCell(hike: hike) })
            } //: List
            .navigationTitle("Hikings")
            
        } //: NavigationView
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - Hike Cell
struct HikeCell: View {
    
    let hike: Hike
    
    var body: some View {
        HStack {
            Image(hike.imageURL)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(16)
            
            VStack(alignment: .leading) {
                Text(hike.name)
                Text(String(format: "%.2f", hike.miles))
            }
        }
    }
}
