//
//  NavigationBarView.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

struct NavigationBarView: View {
    //MARK: - Properties
    @State private var isAnimation: Bool = false
    
    //MARK: - Body
    var body: some View {
        HStack {
            Button(action: {
                
            }, label: {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.black)
            }) //: BUTTON
            
            Spacer()
            LogoView()
                .opacity(isAnimation ? 1 : 0)
                .offset(x: 0, y: isAnimation ? 0 : -25)
                .onAppear {
                    withAnimation(.easeOut(duration: 0.5)) {
                        isAnimation.toggle()
                    }
                }
            Spacer()
            
            Button(action: {
                
            }, label: {
                ZStack {
                    Image(systemName: "cart")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 14, height: 14, alignment: .center)
                        .offset(x: 13, y: -13)
                }
            }) //: BUTTON
        }//: HSTACK
    }
}

//MARK: - Preview
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
