//
//  ExternalWeblinkview.swift
//  Africa
//
//  Created by 김광수 on 2021/04/11.
//

import SwiftUI

struct ExternalWeblinkview: View {
    // MARK: - Properties
    
    let animal: Animal
    
    // MARK: - Body
    var body: some View {
        GroupBox {
            HStack {
                Image(systemName: "globe")
                Text("Wikipedia")
                Spacer()
                
                Group {
                    Image(systemName: "arrow.up.right.square")
                    Link(animal.name, destination: (URL(string: animal.link) ?? URL(string: "https://wikipedia.org"))!)
                }
                .foregroundColor(.accentColor)
            } //: HSTACK
        } //: GroupBox
    }
}

struct ExternalWeblinkview_Previews: PreviewProvider {
    
    static var animals: [Animal] = Bundle.main.decode("animals.json")
    
    static var previews: some View {
        ExternalWeblinkview(animal: animals[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
