//
//  ContentView.swift
//  PresentAndDismissTransitionTutorial
//
//  Created by 김광수 on 2022/04/05.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        OpenSettingView()
    }
}

struct PresentAndDismiss: GeometryEffect { // 에니메이션을 만들기 위해서 필요함
    var offsetValue: Double
    var animatableData: Double {
        get { offsetValue }
        set { offsetValue = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let rotationOffset = offsetValue
        let angleOfRotation = CGFloat(Angle(degrees: 90 * (1-rotationOffset)).radians)
        var transform3D = CATransform3DIdentity
        transform3D.m34 = -1 / max(size.width, size.height)
        
        // 각도 변경 - 아래쪽으로 회전
        transform3D = CATransform3DRotate(
            transform3D,
            angleOfRotation, 1, 0, 0
        )
        
        // 모양 변경
        transform3D = CATransform3DTranslate(
            transform3D,
            -size.width/2.0,
            -size.height/2.0,
            0
        )
        
        let transformAffine1 = ProjectionTransform(
            CGAffineTransform(
                translationX: size.width / 2.0,
                y: size.height / 2.0
            )
        )
        
        let transformAffine2 = ProjectionTransform(
            CGAffineTransform(
                scaleX: CGFloat(offsetValue * 2),
                y: CGFloat(offsetValue * 2)
            )
        )
        
        if offsetValue <= 0.5 {
            return ProjectionTransform(transform3D)
                .concatenating(transformAffine2)        // 스케일
                .concatenating(transformAffine1)        // 회전
        } else {
            return ProjectionTransform(transform3D)
                .concatenating(transformAffine1)        // 회전
        }
    }
}

struct OpenSettingView: View {
    @State private var isShowing = false
    let gradientBackground = Gradient(colors: [.black, .white, .black])
    let buttonBorderGradient = LinearGradient(
        gradient: Gradient(colors: [.black, .white, .black]),
        startPoint: .top,
        endPoint: .bottomTrailing)
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(
                    gradient: gradientBackground,
                    startPoint: .top,
                    endPoint: .bottom)
                .edgesIgnoringSafeArea(.vertical)
                
                VStack {
                    Text("Wack Up").foregroundColor(.black).font(.title)
                    Image(systemName: "clock").font(.largeTitle)
                } //: VSTACK
                
                Button {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.isShowing = true
                    }
                } label: {
                    Image(systemName: "gear")
                        .font(.system(size: 20, weight: .bold))
                } //: BUTTON
                .padding(10)
                .background(Color.orange)
                .cornerRadius(30)
                .foregroundColor(.black)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(buttonBorderGradient, lineWidth: 5)
                        .shadow(color: .gray, radius: 5)
                )
                .offset(y: 200)
                
                if isShowing {
                    SettingsView(show: $isShowing)
                        .transition(.fly)
                        .zIndex(1)
                }
                
            } //: ZSTACK
        } //: VSTACK
    }
}

extension AnyTransition {
    static var fly: AnyTransition {
        get {
            AnyTransition.modifier(
                active: PresentAndDismiss(offsetValue: 0),      // 0 완전히 표현됨
                identity: PresentAndDismiss(offsetValue: 1)     // 1 완전히 사라짐
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
