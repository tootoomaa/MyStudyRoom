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
    var sceneView = ARSKView()
    
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
                NavigationLink("To FaceAnchor",
                               destination: FaceAnchorImportView())
            }
        }
    }
}

struct FaceAnchorImportView: UIViewControllerRepresentable {
    
    // UIViewController를 생성하고 초기화 수행하는 함수
    func makeUIViewController(context: Context) -> some UIViewController {
        
        return FaceViewController()
        
    }
    
    // ViewControoler의 업데이터가 필요할때 호출됨
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    
}

struct FaceAnchorView_Previews: PreviewProvider {
    static var previews: some View {
        FaceAnchorView()
    }
}
