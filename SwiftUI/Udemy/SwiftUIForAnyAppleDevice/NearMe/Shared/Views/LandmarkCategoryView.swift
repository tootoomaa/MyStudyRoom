//
//  LandmarkCategoryView.swift
//  NearMe (iOS)
//
//  Created by 김광수 on 2022/03/23.
//

import SwiftUI

struct LandmarkCategoryView: View {
    
    let categories = ["Groceries", "Hotels", "Coffeo", "Gas", "Takeout", "Pharmacies", "Hotels"]
    let onSelectedCategory: (String) -> ()
    @State private var selectedCategory: String = ""
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(self.categories, id: \.self) { category in
                    Button(action: {
                        self.selectedCategory = category
                        self.onSelectedCategory(category)
                    }) {
                        Text(category)
                    }.padding(10)
                        .foregroundColor(selectedCategory == category ? Color.red : .white)
                        .background(selectedCategory == category ? Color.gray.opacity(0.5) : .black)
                        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                }
            }
        }
    }
}

struct LandmarkCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkCategoryView { _ in }
    }
}
