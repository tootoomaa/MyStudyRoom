//
//  InformationBlurView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/31.
//

import SwiftUI

struct InformationBlurView: View {
    
    @State var isInfomationViewHidden: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
                Image("wwdc")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
                Text("Hello, World!")
            }
//            .blur(radius: isInfomationViewHidden ? 0 : 10)
            
            if !isInfomationViewHidden {
                InfoMationView(isHidden: $isInfomationViewHidden)
            }
        }
    }
}

struct InformationBlurView_Previews: PreviewProvider {
    static var previews: some View {
        InformationBlurView()
    }
}

struct InfoMationView: View {
    
    @Binding var isHidden: Bool
    
    var body: some View {
        
        ZStack {
            
            Color.white
                .opacity(0.95)
                .blur(radius: 0.5)
            
            Color.black
                .opacity(0.25)
            
            
            VStack(alignment: .center) {
                Image("wwdc")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 40)
                
                Text("안내 음성에 따라")
                    .font(.system(size: 26, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.top, 24)
                Text("고개를 들어주세요.")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
                
                Button(action: {
                    self.isHidden = true
                }, label: {
                    Text("시작하기")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.green)
                })
                .frame(width: 280, height: 56)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.top, 30)
            }
            
        }.edgesIgnoringSafeArea(.all)
    }
}
