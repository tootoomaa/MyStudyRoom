//
//  GuideView.swift
//  Honeymoon
//
//  Created by 김광수 on 2021/05/05.
//

import SwiftUI

struct GuideView: View {
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()
                
                Spacer()
                
                Text("Get Started!")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                Text("Discover and pink the perfect destination for your romanfic Honeymoon!")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 10)
                
                VStack(alignment: .center, spacing: 25, content: {
                    GuideComponent(
                      title: "Like",
                      subtitle: "Swipe right",
                      description: "Do you like this destination? Touch the screen and swipe right. It will be saved to the favourites.",
                      icon: "heart.circle")
                    
                    GuideComponent(
                      title: "Dismiss",
                      subtitle: "Swipe left",
                      description: "Would you rather skip this place? Touch the screen and swipe left. You will no longer see it.",
                      icon: "xmark.circle")
                    
                    GuideComponent(
                      title: "Book",
                      subtitle: "Tap the button",
                      description: "Our selection of honeymoon resorts is perfect setting for you to embark your new life together.",
                      icon: "checkmark.square")
                })
                
                Spacer(minLength: 10)
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Countinue".uppercased())
                        .modifier(ButtonModifier())
                })
                
            } //: VSTACK
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
