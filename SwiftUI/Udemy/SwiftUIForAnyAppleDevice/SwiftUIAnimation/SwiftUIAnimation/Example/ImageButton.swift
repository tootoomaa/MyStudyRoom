//
//  ImageButton.swift
//  SwiftUIAnimation
//
//  Created by 김광수 on 2021/06/28.
//

import SwiftUI

struct ImageButton: View {
    
    @State private var isToggle: Bool = false
    @State private var isHidden: Bool = false
    
    var body: some View {
        
        ZStack {
            
            ScrollView(.horizontal) {
                
                
                LazyHStack(content: {
                    ForEach(1...10, id: \.self) { count in
                        
                        if count == 2 {
                            Image("image")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .scaleEffect(0.8)
                                .rotation3DEffect(
                                    .degrees(45), axis: (x: 0, y: 1, z: 0)
                                    //              .degrees(Double(moonGeometry
                                    //                .frame(in: .global).midX - geometry.size.width / 2) / 3),
                                    //              axis: (x: 0, y: 1, z: 0)
                                )

                        } else {
                            
                            Image("image")
                                .resizable()
                                .frame(width: 50, height: 50)
//                                .scaleEffect(0.8)
//                                .rotation3DEffect(
//                                    .degrees(45), axis: (x: 0, y: 1, z: 0)
//                                    //              .degrees(Double(moonGeometry
//                                    //                .frame(in: .global).midX - geometry.size.width / 2) / 3),
//                                    //              axis: (x: 0, y: 1, z: 0)
//                                )
                        }
                    }
                })
                .frame(height: 60)
                .padding(.horizontal, 130)
                .background(Color(.systemGray5))
            }
            
            
            
            //            if isToggle {
            ////                Image("image")
            ////                    .frame(width: 300, height: 300)
            ////                    .transition(.scale)
            ////                    .animation(.easeIn(duration: 4))
            //            }
            //
            //            Button(action: {
            //                isHidden.toggle()
            //                withAnimation(.easeIn(duration: 0.5)) {
            //                    isToggle.toggle()
            //                }
            //            }, label: {
            //                Image("image")
            //                    .resizable()
            //                    .frame(width: isToggle ? UIScreen.main.bounds.width : 200,
            //                           height: isToggle ? UIScreen.main.bounds.height : 200)
            ////                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            //                    .animation(.spring(response: 5, dampingFraction: 0.5, blendDuration: 1))
            ////                    .animation(.interpolatingSpring(mass: 5, stiffness: 100.0, damping: 80, initialVelocity: 0))
            //            })
            //            .opacity(isHidden ? 1 : 0)
            //
            //            Button(action: {
            //                isHidden.toggle()
            //                withAnimation(.easeIn(duration: 0.5)) {
            //                    isToggle.toggle()
            //                }
            //            }, label: {
            //                Image("image")
            //                    .resizable()
            //                    .frame(width: 200, height: 200)
            //                    .clipShape(Circle())
            //            })
            //            .opacity(isHidden ? 0 : 1)
        }
        
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton()
    }
}
