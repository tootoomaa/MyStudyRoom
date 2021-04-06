//
//  TimerView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/31.
//

import SwiftUI

struct TimerView: View {
    
    @State var leftTimeLabel = "00:00"
    @State var timeRemaining = 300
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("\(leftTimeLabel)")
            .font(.title)
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    leftTimeLabel = getTimeLabel(sec: timeRemaining)
                }
            }.onAppear {
                leftTimeLabel = getTimeLabel(sec: timeRemaining)        // 초기 값 선택
            }
    }
    
    private func getTimeLabel(sec: Int) -> String {
        let hour = sec < 60 ? 0 : sec/60
        let minutes = sec % 60
        
        return "\(String(format: "%02d", hour)):\(String(format: "%02d", minutes))"
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
