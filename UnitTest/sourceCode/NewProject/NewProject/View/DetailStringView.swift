//
//  DetailStringView.swift
//  NewProject
//
//  Created by 김광수 on 2021/08/01.
//

import SwiftUI

struct DetailStringView: View {
    
    @State var item: Item
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            Text(item.string)
                .font(.title).bold()
                .foregroundColor(.blue)
            Text("\(item.id)")
            Text("\(item.time)")
        }
        .padding(50)
        .accessibility(identifier: "DetailStringView")
    }
}

struct DetailStringView_Previews: PreviewProvider {
    static var previews: some View {
        DetailStringView(item: Item(time: Date(), string: "Hello"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
