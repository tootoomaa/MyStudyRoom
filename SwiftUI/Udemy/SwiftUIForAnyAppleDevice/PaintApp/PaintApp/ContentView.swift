//
//  ContentView.swift
//  PaintApp
//
//  Created by 김광수 on 2022/03/18.
//

import SwiftUI

struct Line {
    var points = [CGPoint]()
    var color: Color = .red
    var lineWidth: Double = 1.0
}


struct ContentView: View {
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var selectedColor: Color = .red
    @State private var selectedWidth: Double = 1.0
    
    var body: some View {
        VStack {
            
            Canvas { context, size in
                
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path,
                                   with: .color(line.color),
                                   lineWidth: line.lineWidth)
                }
                
            }.gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ value in
                        let newPoint = value.location
                        currentLine.points.append(newPoint)
                        self.lines.append(currentLine)
                    })
                    .onEnded({ value in
                        self.currentLine = Line(points: [],
                                                color: selectedColor,
                                                lineWidth: selectedWidth)
                    })
            )
            
            HStack {
                Slider(value: $selectedWidth, in: 1.0...10.0, onEditingChanged: { _ in
                    self.currentLine.lineWidth = selectedWidth
                }).frame(width: 100, height: 40)
                
                ColorPickerView(selectedColor: $selectedColor)
                    .onChange(of: selectedColor) { self.currentLine.color = $0 }
            }

            
        }.frame(width: 400, height: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
