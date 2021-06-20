//
//  CircleProgressView.swift
//  SwiftUIBuildExamples
//
//  Created by 김광수 on 2021/03/29.
//

import SwiftUI

struct CircleProgressView: View {
    
    @State var sliderValue: Float = 0.0
    @State var progressValue: Float = 0.0
    
    var body: some View {
        ZStack {
            Color.yellow
                .opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    ProgressBar(progress: self.$progressValue)
                        .frame(width: 150.0, height: 150.0)
                        .padding(40.0)
                    Text(String(Int(sliderValue*100)))
                        .font(.title)
                }
                Spacer()
                Slider(value: $sliderValue) {_ in
                    progressValue = sliderValue
                }
                .padding(.horizontal, 30)
                Spacer()
            }
        }
    }
}

struct CircleProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressView()
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))   // 시작위치를 12시 위치로 하기 위해서
                .animation(.easeInOut)                     // 에니메이션
        }
    }
}
