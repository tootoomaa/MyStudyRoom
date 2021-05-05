//
//  HeaderView.swift
//  Honeymoon
//
//  Created by 김광수 on 2021/05/05.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - Properties
    @Binding var showGuide: Bool
    @Binding var showInfo: Bool
    let haptics = UINotificationFeedbackGenerator()
    
    // MARK: - Body
    var body: some View {
        HStack {
            Button(action: {
                playSound(sound: "sound-click", type: "mp3")
                self.haptics.notificationOccurred(.success)
                showInfo.toggle()
            }, label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
            }) //: Info button
            .accentColor(Color.primary)
            .sheet(isPresented: $showInfo, content: {
                InfoView()
            })
            
            Spacer()
            
            Image("logo-honeymoon-pink")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
            
            Spacer()
            
            Button(action: {
                // action
                playSound(sound: "sound-click", type: "mp3")
                self.haptics.notificationOccurred(.success)
                showGuide.toggle()
            }, label: {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24, weight: .regular))
                
            }) //: Question button
            .accentColor(Color.primary)
            .sheet(isPresented: $showGuide, content: {
                GuideView()
            })
        } //: HSTACK
        .padding()
    }
}

// MARK: - Preview
struct HeaderView_Previews: PreviewProvider {
    
    @State static var showGuide: Bool = false
    @State static var showInfo: Bool = false
    
    static var previews: some View {
        HeaderView(showGuide: $showGuide,
                   showInfo: $showInfo)
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
