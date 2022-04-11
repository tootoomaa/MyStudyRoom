//
//  ContentView.swift
//  Twinkling Start
//
//  Created by 김광수 on 2022/04/06.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animateYellow = false
    @State private var animateBlue = false
    @State private var animateRed = false
    @State private var animatePurple = false
    @State private var animateGreen = false
    @State private var startThickness: CGFloat = 0.0
    
    var startPoints: Int = 0
    
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND
            Image("stars").resizable().aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CreateStart(
                    starPoints: 4,
                    startThickness: $startThickness,
                    animateStar: $animateYellow,
                    fillColor: .yellow,
                    starSizeStart: 0.2,
                    starSizeEnd: 0.4,
                    shodowColor: .yellow
                )
                .offset(y: 100)
                .animation(.easeInOut(duration: 2.3).repeatForever(autoreverses: true), value: animateYellow)
                .onAppear {
                    animateYellow.toggle()
                    startThickness = 0.35
                }
                
                CreateStart(
                    starPoints: 6,
                    startThickness: $startThickness,
                    animateStar: $animateBlue,
                    fillColor: .blue,
                    starSizeStart: 0.1,
                    starSizeEnd: 0.43,
                    shodowColor: .blue
                )
                .offset(x: 70, y: -60)
                .animation(.easeInOut(duration: 3.3).repeatForever(autoreverses: true), value: animateBlue)
                .onAppear {
                    animateBlue.toggle()
                    startThickness = 0.35
                }
                
                CreateStart(
                    starPoints: 7,
                    startThickness: $startThickness,
                    animateStar: $animateRed,
                    fillColor: .red,
                    starSizeStart: 0.3,
                    starSizeEnd: 0.2,
                    shodowColor: .red
                )
                .offset(x: 90, y: -90)
                .animation(.easeInOut(duration: 2.3).repeatForever(autoreverses: true), value: animateRed)
                .onAppear {
                    animateRed.toggle()
                    startThickness = 0.35
                }
                
                CreateStart(
                    starPoints: 4,
                    startThickness: $startThickness,
                    animateStar: $animateGreen,
                    fillColor: .green,
                    starSizeStart: 0.2,
                    starSizeEnd: 0.4,
                    shodowColor: .green
                )
                .offset(x: -30, y: 30)
                .animation(.easeInOut(duration: 5.3).repeatForever(autoreverses: true), value: animateGreen)
                .onAppear {
                    animateGreen.toggle()
                    startThickness = 0.35
                }
                                  
            }
        }
    }
}


// MARK: - Start Struct
struct Star: Shape {
    
    let starPoints: Int
    var starThickness: CGFloat
    var animatableData: CGFloat {
        get { starThickness }
        set { starThickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        
        guard starPoints >= 3 else { return Path() }
        // create an x and y start the drawing from
        let drawPoint = CGPoint(x: rect.width / 1.2, y: rect.height / 0.5)
        
        // make the angle of the start straight up (change this value to chage the start angle)
        var starAngle = -CGFloat.pi / 2                              // 180
        let adjustedStartAndle = .pi * 2 / CGFloat(starPoints * 2)
        
        let pointX = drawPoint.x * starThickness
        let pointY = drawPoint.y * starThickness
        
        //create a path instance to start the drawing
        var path = Path()
        
        path.move(to: CGPoint(x: drawPoint.x * cos(starAngle), y: drawPoint.y * sin(starAngle)))
        
        // keep track of the lowest point so we can create it
        var bottomEdge: CGFloat = 0
        
        for corner in 0..<starPoints * 2 {
            let sinAngle = sin(starAngle)
            let cosAngle = cos(starAngle)
            let bottom: CGFloat
            
            // check to see if we are a multiple of two. if so, then we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                // store this position in bottom
                bottom = drawPoint.y * sinAngle
                // add a line to there
                path.addLine(to: CGPoint(x: drawPoint.x * cosAngle, y: bottom))
            } else {
                // in the else, we're not a multiple of 2, so we are drawing an inner point
                // store this y position in bottom
                bottom = pointY * sinAngle
                // add line
                path.addLine(to: CGPoint(x: pointX * cosAngle, y: bottom))
            }
            
            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            
            // move to next corner
            starAngle += adjustedStartAndle
        }
        
        // calculate how much unused space we have at the bottom of our drawing rectangle
        let bottomSpace = (rect.height/2 - bottomEdge) / 2
        
        // create and add a transfrom that oves the path down by that amount, cetering the shpae vertically
        let transform = CGAffineTransform(translationX: drawPoint.x, y: drawPoint.y + bottomSpace)
        
        return path.applying(transform)
    }
}

struct CreateStart: View {
    var starPoints: Int
    @Binding var startThickness: CGFloat
    @Binding var animateStar: Bool
    
    var fillColor: Color
    var starSizeStart: CGFloat
    var starSizeEnd: CGFloat
    var shodowColor: Color
    
    var body: some View {
        VStack {
            Star(starPoints: starPoints, starThickness: startThickness)
                .fill(fillColor)
                .frame(width: 80, height: 80)
                .scaleEffect(animateStar ? starSizeStart : starSizeEnd)
                .shadow(color: shodowColor, radius: 20, x: 3, y: 3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
