//
//  FaceAnchorView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/31.
//

import SwiftUI
import ARKit

struct FaceAnchorView: View {
    
    @State private var textToShow = "Hello AR"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(textToShow)
                    .foregroundColor(.white)
                    .bold().font(.title)
                Button(action: {
                    self.textToShow = "Button Tapped!"
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .frame(width: 150, height: 50)
                        Text("Tap Me")
                    }
                }
            }
        }
    }
}

//struct MySwiftUIView: UIViewRepresentable {
//    typealias UIViewType: UIView
//    
//    func makeUIView(context: Context) -> UIViewType {
//        // View를 원하는대로 생성하는 곳
//        let view = FaceViewController()
//        return view
//    }
//    
//    func updateUIView(_ view: UIViewType, context: Context) {
//        // View를 원하는대로 수정하는 곳
//    }
//}

struct FaceAnchorView_Previews: PreviewProvider {
    static var previews: some View {
        FaceAnchorView()
    }
}
