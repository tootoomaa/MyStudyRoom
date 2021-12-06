//
//  ContentView.swift
//  AbocadoStarsApp
//
//  Created by 김광수 on 2021/12/06.
//

/*
 Building Custom Views with SwiftUI
  https://developer.apple.com/videos/play/wwdc2019/237/
 
  First Session
 */

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        HStack(alignment: .midStarAndTitle) {
            VStack {
                Text("❤️❤️❤️❤️❤️")
                    .alignmentGuide(.midStarAndTitle) { d in d[.bottom]/2 }
                Text("5 stars")
            }
            .font(.caption)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Avocado Toast").font(.title)
                        .alignmentGuide(.midStarAndTitle) { d in d[.bottom]/2 }
                    Spacer()
                    Image("avocado")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Text("Ingredients: Avocado, Almond Butter, Bread, Red Peper")
                    .font(.footnote)
                    .lineLimit(1)
            }
                    
        }
        
    }
}

extension VerticalAlignment {
    private enum MidStarAndTitle: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context[.bottom]
        }
    }
    
    static let midStarAndTitle = VerticalAlignment(MidStarAndTitle.self)
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
