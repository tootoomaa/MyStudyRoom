//
//  ContentView.swift
//  CircleTest
//
//  Created by 김광수 on 2022/04/06.
//

import SwiftUI

struct ContentView: View {
    
    enum AngleType {
        case dot
        case line
    }
    
    private var buttonCircleWidth: CGFloat      // 중앙 버튼 원 지름
    private var progressCricleWidth: CGFloat    // 외곽 진행 사항 원 지름
    private var circleRoundLength: CGFloat      // 원둘래 길이
    private var padding: CGFloat = 30           // 진행 사항 별 거리 (30)
    private var activityCount: Int = 10
    private var dotAngle: Angle {
        Angle(degrees: Double(360.0/Double(activityCount)))
    }
    
    private var lineAngle: Angle {
        Angle(degrees: Double(360.0/Double(activityCount/2)))
    }
    
    private func getAngle(_ type: AngleType, mul: Int) -> Angle {
        var angle: Double = 0.0
        
        switch type {
        case .dot:  angle = 90.0 + Double(360.0/Double(activityCount)) * Double(mul)
        case .line: angle = 90.0 + Double(360.0/Double(activityCount/2)) * Double(mul)
        }
        
        return Angle(degrees: angle)
    }
    
    init() {
        let width = UIScreen.main.bounds.width*8/10               // 원지름
        self.buttonCircleWidth = width                      // 버튼 원 지름 저장
        self.progressCricleWidth = (width + 25)             // 프로그래스 원 지름 저장 (+padding)
        self.circleRoundLength = progressCricleWidth * 3.14 // 프로그래스 원주율 저장
    }
    
    var body: some View {
        ZStack {
            
            Color(UIColor.green).opacity(0.2).edgesIgnoringSafeArea(.all)
            
            ZStack() { // Circle Seperate lines
                
                Circle()
                    .stroke(lineWidth: 3)
                    .foregroundColor(.red)
                    .frame(width: buttonCircleWidth, height: buttonCircleWidth)
                
                // MARK: - Dot Line
                ForEach(0..<activityCount, id: \.self) { index in
                    HStack {
                        Rectangle()
                            .foregroundColor(.orange)
                            .frame(width: 12, height: index%2 == 0 ? 4 : 2)
                            .opacity(index%2 == 0 ? 1 : 0.5)
                        Spacer()
                    } //: HSTACK - Line
                    .rotationEffect(getAngle(.dot, mul: index))
                } //: ForEach Loop
                
//                // MARK: - Whie Line
                ForEach(0..<activityCount/2, id: \.self) { index in
                    HStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: buttonCircleWidth/2, height: 5)
                        Spacer()
                    } //: HSTACK - Line
                    .rotationEffect(getAngle(.line, mul: index))
                } //: ForEach Loop
            }
            .frame(width: buttonCircleWidth, height: buttonCircleWidth)
            .clipShape(Circle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
