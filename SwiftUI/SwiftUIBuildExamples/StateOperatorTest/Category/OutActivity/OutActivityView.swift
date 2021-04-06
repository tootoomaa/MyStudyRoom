//
//  OutActivityView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/30.
//

import SwiftUI

struct OutActivityView: View {
    
    //MARK: - UIController
    let horizenEdgePadding: CGFloat = 15
    
    let munus: [String] = ["고개 들기", "고개 돌리기", "휴대전화 들기", "화면 누르기 게임"]
    
    var body: some View {
        
        GeometryReader { gr in
            ScrollView {
                
                Image("wwdc")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.4)
                    .frame(width: gr.size.width)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Alaph님의")
                        .font(.system(size: 20))
                    Text("11번째 외적 활동입니다.")
                        .font(.system(size: 25))
                    Text("신체를 사용한 능동적인 운동입니다.")
                }
                .minimumScaleFactor(0.6)
                .frame(width: gr.size.width-horizenEdgePadding*2, alignment: .leading)
                
                ZStack {
                    Circle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [6]))
                        .foregroundColor(Color.green)
                        .frame(width: gr.size.width*0.6, height: gr.size.width*0.6)
                    VStack {
                        Text("남은 시간")
                            .font(.system(size: 20))
                        Text("20:20")
                            .font(.system(size: 40))
                    }
                }.padding(.top, 50)
                .padding(.bottom, 50)
                
                ForEach(munus, id: \.self) { menu in
                    Text(menu.capitalized)
                        .padding()
                        .frame(width: gr.size.width-20, height: 120)
                        .background(Color.red)
                        .cornerRadius(20)
                }
                
                Rectangle()
                    .foregroundColor(.red)
                    .cornerRadius(10)
                    .frame(width: gr.size.width-20, height: 120)
                
                Rectangle()
                    .foregroundColor(.red)
                    .cornerRadius(10)
                    .frame(width: gr.size.width-20, height: 120)
                
            }
            .edgesIgnoringSafeArea(.top)
            
        }
    }
}

struct OutActivityView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                OutActivityView()
            }
        }
    }
}
