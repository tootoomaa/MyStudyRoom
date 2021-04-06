//
//  RulerView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/30.
//

import SwiftUI

struct RulerView: View {
    var body: some View {
        
        GeometryReader(content: { gr in
             
            VStack {
                
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    
                    Rectangle()
                        .foregroundColor(.green)
                        .frame(width: gr.size.width*10, height: 80, alignment: .bottom)
                    
                }).frame(width: gr.size.width, height: 100, alignment: .center)
                
            }
        })
        
    }
}

struct RulerView_Previews: PreviewProvider {
    static var previews: some View {
        RulerView()
    }
}
