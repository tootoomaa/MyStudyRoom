//
//  CreateHypedEventSectionView.swift
//  UpcommingApp
//
//  Created by 김광수 on 2021/03/18.
//

import SwiftUI

struct CreateHypedEventSectionView: View {
    
    let title: String
    let color: Color
    let imageName: String
    
    init(_ image: String, _ color: Color, _ title: String) {
        self.title = title
        self.color = color
        self.imageName = image
    }
    
    var body: some View {
        Label {
                Text(title)
        } icon: {
            Image(systemName: imageName)
                .padding(4)
                .background(color)
                .cornerRadius(7)
                .foregroundColor(.white)
        }
    }
}

struct CreateHypedEventSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventSectionView("keyboard", .blue, "Title")
    }
}
