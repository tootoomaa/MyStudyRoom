//
//  RecordPlayerBox.swift
//  RecordPlayer (iOS)
//
//  Created by 김광수 on 2022/03/30.
//

import SwiftUI

struct RecordPlayerBox: View {
    var body: some View {
        ZStack {
            Rectangle().frame(width: 345, height: 345).cornerRadius(10)
                .foregroundColor(.black)
            Image("woodGrain").resizable().frame(width: 325, height: 325)
                .shadow(color: .white, radius: 3, x: 0, y: 0)
        }
    }
}

struct RecordPlayerBox_Previews: PreviewProvider {
    static var previews: some View {
        RecordPlayerBox()
    }
}
