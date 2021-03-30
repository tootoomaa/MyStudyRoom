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
    
    init(_ image: String, _ title: String, _ color: Color) {
        self.title = title
        self.color = color
        self.imageName = image
    }
    
    var body: some View {
        Label {
                Text(title)
                    .foregroundColor(.black)
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
        CreateHypedEventSectionView("keyboard", "Title", .blue)
    }
}
