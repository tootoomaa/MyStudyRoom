//
//  NewGoodNewsView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/07.
//

import SwiftUI

struct NewGoodNewsView: View {
    
    @ObservedObject var viewModel = NewGoodNewsViewModel()
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            List(viewModel.articleList.articles) { article in
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.system(size: 15, weight: .bold))
                    Text(article.description ?? "")
                        .font(.system(size: 10))
                } //: VSTACK
            } //: LIST
            if viewModel.isAnimating {
                ProgressView()
            }
        } //: ZSTACK
    }
}

struct NewGoodNewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoodNewsView()
    }
}
