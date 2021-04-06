//
//  GoodNews().swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import SwiftUI

struct GoodNews: View {
    
    let viewModel = GoodNewViewModel()
    
//    @State var articleResponse = ArticleResponse(articles: [])
    
    var body: some View {
        List(viewModel.articleList.articles) { article in
            VStack(alignment: .leading) {
                Text(article.title)
                    .bold()
                    .font(.subheadline)
                Text(article.description ?? "")
            }
        }.onAppear {
            print("Appear")
//            _ = viewModel.getGoodNews()
//                .sink { result in
//                    print("get Data")
//                    self.articleResponse = result
//                }
        }
    }
}

struct GoodNews_Previews: PreviewProvider {
    
    static var previews: some View {
        GoodNews()
    }
}
