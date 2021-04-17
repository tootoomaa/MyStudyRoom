//
//  BrandGridView.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/14.
//

import SwiftUI

struct BrandGridView: View {
    //MARK: - Properties
    
    //MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridLayout, spacing: columnSpacing, content: {
                ForEach(brands) { item in
                    BrandItemView(brand: item)
                } //: LOOP
            }) //: LazyHGrid
            .frame(height: 200)
            .padding(15)
        } //: ScrollView
    }
}

//MARK: - Preview
struct BrandGridView_Previews: PreviewProvider {
    static var previews: some View {
        BrandGridView()
            .previewLayout(.sizeThatFits)
            .background(colorBackgroud)
    }
}
