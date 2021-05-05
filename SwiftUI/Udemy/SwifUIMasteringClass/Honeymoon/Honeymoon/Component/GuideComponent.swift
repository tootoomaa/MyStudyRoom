//
//  GuideComponent.swift
//  Honeymoon
//
//  Created by 김광수 on 2021/05/05.
//

import SwiftUI

struct GuideComponent: View {
    // MARK: - Properties
    var title: String
    var subtitle: String
    var description: String
    var icon: String
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(Color.pink)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title.uppercased())
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    Spacer()
                    
                    Text(subtitle.uppercased())
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.pink)
                } //: HSTACK
                Divider().padding(.bottom, 4)
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: false)
            } //: VSTACL
        } //: HSTACK
    }
}

struct GuideComponent_Previews: PreviewProvider {
    static var previews: some View {
        GuideComponent(title: "title", subtitle: "Swipe right", description: "this is placeholder. change this latter", icon: "heart.circle")
            .previewLayout(.sizeThatFits)
    }
}
