//
//  InsetFactView.swift
//  Africa
//
//  Created by 김광수 on 2021/04/10.
//

import SwiftUI

struct InsetFactView: View {
    // MARK: - Properties
    
    let animal: Animal
    
    // MARK: - Body
    var body: some View {
        GroupBox {
            TabView {
                ForEach(animal.fact, id: \.self) { item in
                    Text(item)
                }
            } //: TabView
            .tabViewStyle(PageTabViewStyle())
            .frame(minHeight: 148, maxHeight: 180)
        } //: GroupBox
    }
}

// MARK: - Preview
struct InsetFactView_Previews: PreviewProvider {
    
    static let animals: [Animal] = Bundle.main.decode("animals.json")
    
    static var previews: some View {
        InsetFactView(animal: animals[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
