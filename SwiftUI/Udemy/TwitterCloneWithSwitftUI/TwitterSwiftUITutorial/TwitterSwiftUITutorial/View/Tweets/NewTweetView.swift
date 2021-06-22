//
//  NewTweetView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/22.
//

import SwiftUI

struct NewTweetView: View {
    // MARK: - Properties
    @Binding var isPresented: Bool
    @State var captionText: String = ""
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            
            VStack {
                HStack(alignment: .top) {
                    Image("batman")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 64, height: 64)
                        .cornerRadius(32)
                    
                    TextArea("Wahat's happing?",
                             text: $captionText)
                        .foregroundColor(.gray)
                    
                    Spacer()
                } //: HStack
                .padding()
                .navigationBarItems(leading:
                                        Button(action: { isPresented.toggle() }, label: {
                                            Text("Cancel")
                                                .foregroundColor(.blue)
                                        }),
                                    trailing:
                                        Button(action: { }, label: {
                                            Text("Tweet")
                                                .padding(.horizontal)
                                                .padding(.vertical, 8)
                                                .background(Color.blue)
                                                .foregroundColor(.white)
                                                .clipShape(Capsule())
                                        })
                )
                Spacer()
            } // VSTACK
        }//: NavigationView
    }
}

// MARK: - PreviewZ
struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView(isPresented: .constant(true))
    }
}
