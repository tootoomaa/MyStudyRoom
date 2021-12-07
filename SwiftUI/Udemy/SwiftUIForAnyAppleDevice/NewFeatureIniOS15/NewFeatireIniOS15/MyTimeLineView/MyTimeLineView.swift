//
//  MyTimeLineView.swift
//  AysncImageTestApp
//
//  Created by 김광수 on 2021/12/04.
//

import SwiftUI

struct MyTimeLineView: View {
    var body: some View {
        VStack {
            TimelineView(PeriodicTimelineSchedule(from: Date(), by: 1)) { context in
                Text("\(context.date)")
            }
        }
    }
}

struct MyTimeLineView_Previews: PreviewProvider {
    static var previews: some View {
        MyTimeLineView()
    }
}
