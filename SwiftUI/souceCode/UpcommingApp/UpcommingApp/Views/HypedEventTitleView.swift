//
//  HypedEventTitleView.swift
//  UpcommingApp
//
//  Created by 김광수 on 2021/03/21.
//

import SwiftUI

struct HypedEventTitleView: View {
    
    var hypedEvent: HypedEvent
    
    var body: some View {
        
        VStack(spacing: 0) {
            if let image = hypedEvent.image() {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Rectangle()
                .foregroundColor(hypedEvent.color)
                .frame(height: 15)
            
            HStack {
                Text(hypedEvent.title)
                    .font(.title)
                    .padding(10)
                Spacer()
            }
            .background(Color.white)
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.red)
                Text(hypedEvent.dataAsString())
                    
                Spacer()
                Text(hypedEvent.timeFromNow())
                Image(systemName: "clock.fill")
                    .foregroundColor(.blue)
            }
            .font(.title3)
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .background(Color.white)
        }
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .background(Color.white)
    }
}

struct HypedEventTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HypedEventTitleView(hypedEvent: testHypedEvent1)
    }
}
