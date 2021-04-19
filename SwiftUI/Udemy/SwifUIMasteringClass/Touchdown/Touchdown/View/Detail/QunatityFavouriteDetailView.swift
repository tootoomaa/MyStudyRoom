//
//  QunatityFavouriteDetailView.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/15.
//

import SwiftUI

struct QunatityFavouriteDetailView: View {
    //MARK: - Properties
    @State private var counter: Int = 0
    
    //MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 6, content: {
            Button(action: {
                feedback.impactOccurred()
                if counter > 0 {
                    counter -= 1
                }
                
            }, label: {
                Image(systemName: "minus.circle")
            })
            
            Text("\(counter)")
                .fontWeight(.semibold)
                .frame(minWidth: 36)
            
            Button(action: {
                feedback.impactOccurred()
                if counter < 100 {
                    counter += 1
                }
            }, label: {
                Image(systemName: "plus.circle")
            })
            
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "heart.circle")
                    .foregroundColor(.pink)
            })
            
        }) //: HSTACK
        .font(.system(.title, design: .rounded))
        .foregroundColor(.black)
        .imageScale(.large)
        
    }
}

//MARK: - Preview
struct QunatityFavouriteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        QunatityFavouriteDetailView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
