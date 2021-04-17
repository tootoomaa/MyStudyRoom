//
//  CustomNavigationBarView.swift
//  Devote
//
//  Created by 김광수 on 2021/04/17.
//

import SwiftUI

struct CustomNavigationBarView: View {
    
    @State var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
        } //: HSTAKC
    }
}

struct CustomNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBarView(title: "Devote")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
