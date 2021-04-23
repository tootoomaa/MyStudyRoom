//
//  AvocadosView.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/23.
//

import SwiftUI

struct AvocadosView: View {
    // MARK: - Properties
    @State private var plusateAnimaion: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            Image("avocado")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 240, height: 240, alignment: .center)
                .shadow(color: Color("ColorBlackTransparentDark"), radius: 12, x: 0, y: 8)
                .scaleEffect(self.plusateAnimaion ? 1 : 0.9)
                .opacity(self.plusateAnimaion ? 1 : 0.9)
                .animation(Animation.easeInOut(duration: 1.5).repeatForever())
            
            VStack {
                Text("Avocados".uppercased())
                    .font(.system(size: 42, weight: .bold, design: .serif))
                    .foregroundColor(Color.white)
                    .padding()
                    .shadow(color: Color("ColorBlackTransparentDark"), radius: 12, x: 0, y: 8)
                Text("""
Creamy, green, and full of nutrients!
 Avocado is a powerhouse ingredient at any meal. Enjoy these handpicked avocado recipes for breakfast, lunch, dinner & more!
""")
            }
            .lineLimit(nil)
            .font(.system(.headline))
            .foregroundColor(Color("ColorGreenLight"))
            .multilineTextAlignment(.center)
            .lineSpacing(8)
            .frame(maxWidth: 640, minHeight: 120)
            
            Spacer()
        }
        .background(
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.plusateAnimaion = true
        }
    }
}

// MARK: - PreView
struct AvocadosView_Previews: PreviewProvider {
    static var previews: some View {
        AvocadosView()
            .environment(\.colorScheme, .dark)
    }
}
