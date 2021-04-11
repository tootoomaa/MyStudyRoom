//
//  AnimalDetailView.swift
//  Africa
//
//  Created by 김광수 on 2021/04/10.
//

import SwiftUI

struct AnimalDetailView: View {
    // MARK: - Properties
    
    let animal: Animal
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                
                // Hero Image
                Image(animal.image)
                    .resizable()
                    .scaledToFit()
                
                // Title
                Text(animal.name.uppercased())
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                    .foregroundColor(.primary)
                    .background(
                        Color.accentColor
                            .frame(height: 6)
                            .offset(y: 24)
                    )
                
                // HeadLink
                Text(animal.headline)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.accentColor)
                    .padding(.horizontal)
                
                // Gallery
                Group {
                    HeadingView(headingImage: "photo.on.rectangle.angled",
                                headingText: "Wilderness in Picktures")
                    InsetGalleryView(animal: animal)
                }
                .padding(.horizontal)
                
                // Facts
                Group {
                    HeadingView(headingImage: "questionmark.circle",
                                headingText: "Did you know?")
                    InsetFactView(animal: animal)
                }
                .padding(.horizontal)
                
                // Description
                Group {
                    HeadingView(headingImage: "info.circle",
                                headingText: "All About Lion")
                    Text(animal.description)
                        .multilineTextAlignment(.leading)
                        .layoutPriority(1)
                }
                .padding(.horizontal)
                
                // map
                Group {
                    HeadingView(headingImage: "map",
                                headingText: "National Parks")
                    InsetMapView()
                }
                .padding(.horizontal)
                
                // Line
                Group {
                    HeadingView(headingImage: "books.vertical",
                                headingText: "Learn More")
                    ExternalWeblinkview(animal: animal)
                }
                .padding(.horizontal)
                 
            } //: VStack
            .navigationBarTitle("Learn abount \(animal.name)", displayMode: .inline)
        } //: ScrollView
    }
}

// MARK: - Previews
struct AnimalDetailView_Previews: PreviewProvider {
    
    static let animals: [Animal] = Bundle.main.decode("animals.json")
    
    static var previews: some View {
        AnimalDetailView(animal: animals[0])
    }
}
