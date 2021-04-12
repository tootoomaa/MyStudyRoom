//
//  HeadingView.swift
//  Africa
//
//  Created by 김광수 on 2021/04/10.
//

import SwiftUI

struct HeadingView: View {
    // MARK: - Properteis
    
    var headingImage: String
    var headingText: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            
            Image(systemName: headingImage)
                .foregroundColor(.accentColor)
                .imageScale(.large)
            
            Text(headingText)
                .font(.title3)
                .fontWeight(.bold)
            
        } //: HStack
        .padding(.horizontal)
    }
}

// MARK: - Preview
struct HeadingView_Previews: PreviewProvider {
    static var previews: some View {
        HeadingView(headingImage: "photo.on.rectangle.angled",
                    headingText: "Widle animal")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
