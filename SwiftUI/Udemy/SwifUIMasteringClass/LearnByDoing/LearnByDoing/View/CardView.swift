//
//  CardView.swift
//  LearnByDoing
//
//  Created by 김광수 on 2021/04/22.
//

import SwiftUI

struct CardView: View {
    // MARK: - Properties
    var gradient: [Color] = [Color("Color01"), Color("Color02")]
    var card: Card
    
    @State private var fadeIn: Bool = false
    @State private var movewDownward: Bool = false
    @State private var movewUpward: Bool = false
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Image(card.imageName)
                .opacity(fadeIn ? 1.0 : 0.0)
            
            VStack {
                Text(card.title)
                    .font(.title)
                    .bold()
                    .fontWeight(.heavy)
                Text(card.headline)
                    .fontWeight(.light)
            } //: VSTACK
            .foregroundColor(.white)
            .offset(y: movewDownward ? -218 : -300)

            Button(action: {
                print("Button was tapped")
                playSound(sound: "sound-chime", type: "mp3")
            }, label: {
                HStack {
                    Text(card.callToAction)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                        .accentColor(.white)
                    
                    Image(systemName: "arrow.right.circle")
                        .foregroundColor(.white)
                        .accentColor(.white)
                } //: HSTACK
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: card.gradientColors),
                                           startPoint: .leading, endPoint: .trailing))
                .cornerRadius(16)
                .shadow(radius: 8)
                .clipShape(Capsule())
            }) //: Button
            .offset(y: movewUpward ? 210 : 300 )
            
        } //: ZSTACK
        .frame(width: 335, height: 545)
        .background(LinearGradient(gradient: Gradient(colors: card.gradientColors),
                                   startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(16)
        .shadow(radius: 8)
        .onAppear {
            withAnimation(.linear(duration: 1.2)) {
                self.fadeIn.toggle()
            }
            withAnimation(.linear(duration: 0.8)) {
                self.movewDownward.toggle()
                self.movewUpward.toggle()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardView(card: cardData[1] )
            .previewLayout(.sizeThatFits)
    }
}
