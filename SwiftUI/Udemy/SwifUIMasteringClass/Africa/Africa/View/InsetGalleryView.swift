//
//  InsetGalleryView.swift
//  Africa
//
//  Created by 김광수 on 2021/04/10.
//

import SwiftUI

struct InsetGalleryView: View {
    // MARK: - Properteis
    
    let animal: Animal
    
    // MARK: - Body
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(animal.gallery, id: \.self) { animal in
                    Image(animal)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                }
            } //: HStack
        } //: ScrollView
    }
}

// MARK: - Preview
struct InsetGalleryView_Previews: PreviewProvider {
    
    static let animals: [Animal] = Bundle.main.decode("animals.json")
    
    static var previews: some View {
        InsetGalleryView(animal: animals[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
