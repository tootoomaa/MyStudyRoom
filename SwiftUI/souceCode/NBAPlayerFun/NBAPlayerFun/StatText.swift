//
//  StatText.swift
//  NBAPlayerFun
//
//  Created by 김광수 on 2021/01/29.
//

import SwiftUI

struct StatText: View {
    var statName: String
    var statValue: String
//
//    init(_ menu: String, _ value: String) {
//        self.menu = menu
//        self.value = value
//    }

    var body: some View {
        HStack() {
            Text(statName + ":")
                .font(.system(size: 45))
                .fontWeight(.heavy)
                .padding(.leading, 30)
            Text(statValue)
                .font(.system(size: 45))
                .fontWeight(.light)
                .padding(.trailing, 30)
            Spacer()
        }.minimumScaleFactor(0.6)
    }
}

struct StatText_Previews: PreviewProvider {
    static var previews: some View {
        StatText(statName: "Age", statValue: "55")
    }
}
