//
//  GoodNews().swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import SwiftUI

struct GoodNews: View {
    
    let viewModel = GoodNewViewModel()
    
    var body: some View {
        List(viewModel.articleList.articles) { article in
            VStack(alignment: .leading) {
                Text(article.title)
                    .bold()
                    .scaledFont(size: 15)
                Text(article.description ?? "")
                    .scaledFont(size: 10)
                
            }
        }
    }
}

struct GoodNews_Previews: PreviewProvider {
    
    static var previews: some View {
        GoodNews()
    }
}
