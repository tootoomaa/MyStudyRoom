//
//  DisplayInfomationView.swift
//  ARKitVision
//
//  Created by 김광수 on 2021/12/13.
//

import SwiftUI

struct DisplayInfomationView: View {
    
    var handPose: HandPose
    
    var body: some View {
        Text(self.handPose.rawValue)
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 100, height: 80)
            .background(Color.blue)
            .cornerRadius(20)
    }
}

struct DisplayInfomationView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayInfomationView(handPose: .rock)
    }
}
