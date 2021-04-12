//
//  AnimalGridItemView.swift
//  Africa
//
//  Created by 김광수 on 2021/04/12.
//

import SwiftUI

struct AnimalGridItemView: View {
    // MARK: - Properties
    
    let animal: Animal
    
    var body: some View {
        Image(animal.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(20)
    }
}

struct AnimalGridItemView_Previews: PreviewProvider {
    
    static let animals: [Animal] = Bundle.main.decode("animals.json")
    
    static var previews: some View {
        AnimalGridItemView(animal: animals[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
