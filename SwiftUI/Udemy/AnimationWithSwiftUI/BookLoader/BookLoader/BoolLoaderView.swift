//
//  ContentView.swift
//  BookLoader
//
//  Created by 김광수 on 2022/04/12.
//

import SwiftUI

struct BoolLoaderView: View {
    
    @State var bookState: BookLoaderState = .closeRight
    
    @State var leftCoverOffset: CGSize = CGSize(width: -84, height: 0)
    @State var leftRotationDegree: Angle = .zero
    
    @State var middleBookOffset: CGSize = CGSize(width: -28, height: -28)
    @State var middleRotationDegress: Angle = .degrees(-90)
    
    @State var rightCoverOfsset: CGSize = CGSize(width: 84, height: 55.75)
    @State var rightRotationDegree: Angle = .degrees(-180)
    
    @State var currentIndex = 0
    @State var animationStart: Bool = false
    
    let bookCoverWidth: CGFloat = 120
    let animationDuration: TimeInterval = 0.4
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            // left Book Cover
            Capsule().foregroundColor(.white).frame(width: bookCoverWidth, height: 8).offset(leftCoverOffset)
            
            // Spine
            BookHolder().stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
                .foregroundColor(.white)
                .rotationEffect(middleRotationDegress).offset(middleBookOffset)
            
            // right Book Cover
            Capsule().foregroundColor(.white).frame(width: bookCoverWidth, height: 8).offset(rightCoverOfsset)
                .rotationEffect(rightRotationDegree)
            
            // pages in the middle
            BookPagesView(animationStarted: $animationStart, animationDuration: animationDuration)
                .offset(y: -20)
        }
        .onTapGesture {
            self.animationStart.toggle()
            animateBookCovers()
            Timer.scheduledTimer(withTimeInterval: animationDuration * 3.4, repeats: false) { _ in
                animateBookClose()
                
                Timer.scheduledTimer(withTimeInterval: animationDuration * 5, repeats: true) { _ in
                    animateBookClose()
                }
            }
        }
    }
    
    // MARK: - FUNTIONS
    func animateBookCovers() {
        withAnimation(.easeOut(duration: animationDuration)) {
            middleRotationDegress = bookState.animationBegin.3
            middleBookOffset = bookState.animationBegin.2
        }
        
        withAnimation(.easeOut(duration: animationDuration)) {
            leftCoverOffset = bookState.animationBegin.0
            rightCoverOfsset = bookState.animationBegin.4
        }
        
        withAnimation(.easeOut(duration: animationDuration).delay(animationDuration * 0.05)) {
            leftRotationDegree = bookState.animationBegin.1
            rightRotationDegree = bookState.animationBegin.5
        }
    }
    
    func animateBookClose() {
        withAnimation(.linear(duration: animationDuration)) {
            middleRotationDegress = bookState.animationEnd.3
            leftCoverOffset = bookState.animationEnd.0
            rightCoverOfsset = bookState.animationEnd.4
        }
        withAnimation(.easeOut(duration: animationDuration)) {
            leftRotationDegree = bookState.animationEnd.1
            rightRotationDegree = bookState.animationEnd.5
            middleBookOffset = bookState.animationEnd.2
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration*1.6, repeats: false) { _ in
            bookState = getNextCase()
            animateBookCovers()
        }
    }
    
    func getNextCase() -> BookLoaderState {
        let allcase = BookLoaderState.allCases
        
        if currentIndex == allcase.count - 1 {
            currentIndex = -1
        }
        
        currentIndex += 1
        let index = currentIndex
        return allcase[index]
    }
}

enum BookLoaderState: CaseIterable {
    case closeRight
    case closeLeft
    var animationBegin: (CGSize, Angle, CGSize, Angle, CGSize, Angle) {
        switch self {
        case .closeRight:
            return (CGSize(width: -84, height: 0), Angle.degrees(0), CGSize(width: 0, height: 0), Angle.degrees(0), CGSize(width: 84, height: 0), Angle.degrees(0))
        case .closeLeft:
            return (CGSize(width: -84, height: 0), Angle.degrees(0), CGSize(width: 0, height: 0), Angle.degrees(0), CGSize(width: 84, height: 0), Angle.degrees(0))
        }
    }
    
    var animationEnd: (CGSize, Angle, CGSize, Angle, CGSize, Angle) {
        switch self {
        case .closeRight:
            return (CGSize(width: -84, height: 55.75), Angle.degrees(180), CGSize(width: 28, height: -28), Angle.degrees(90), CGSize(width: 84, height: 0), Angle.degrees(0))
        case .closeLeft:
            return (CGSize(width: -84, height: 0), Angle.degrees(0), CGSize(width: -28, height: -28), Angle.degrees(-90), CGSize(width: 84, height: 55.75), Angle.degrees(-180))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BoolLoaderView()
    }
}
