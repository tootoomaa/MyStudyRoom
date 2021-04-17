//
//  TitleView.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/14.
//

import SwiftUI

struct TitleView: View {
    //MARK: - Properties
    
    var title: String
    
    //MARK: - Body
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.heavy)
            Spacer()
        } //: HSTACK
        .padding(.horizontal)
        .padding(.top, 15)
        .padding(.bottom, 10)
    }
}

//MARK: - Preview
struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Helmet")
            .previewLayout(.sizeThatFits)
    }
}
