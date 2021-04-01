//
//  GoodNews().swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import SwiftUI

struct GoodNews: View {
    
    @EnvironmentObject var provider: ServiceProvider
    
    @State var list: [Article] = []
    
    var body: some View {
        List(list) { article in
            VStack(alignment: .leading) {
                Text(article.title)
                    .bold()
                    .font(.subheadline)
                Text(article.description ?? "")
            }
        }
        .onAppear {
            
            self.list = provider.newsService.articleList.articles
        }
    }
}

struct GoodNews_Previews: PreviewProvider {
    static var previews: some View {
        GoodNews()
    }
}
