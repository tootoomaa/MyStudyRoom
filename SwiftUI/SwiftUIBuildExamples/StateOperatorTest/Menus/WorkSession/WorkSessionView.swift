//
//  WorkSessionView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/12.
//

import SwiftUI

struct WorkSessionView: View {
    
    let service = WorkSessionService()
    
    var body: some View {
        Image("bloodsugar-img")
            .resizable()
            .scaledToFit()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
        
        
    }
}

struct WorkSessionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkSessionView()
    }
}
