//
//  ColorPickerView.swift
//  PaintApp
//
//  Created by 김광수 on 2022/03/18.
//

import SwiftUI

struct ColorPickerView: View {
    
    let colors: [Color] = [.red, .orange, .green, .cyan, .blue]
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(self.colors, id: \.self) { color in
                ZStack {
                    Circle()
                        .foregroundColor(color)
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .opacity(color == self.selectedColor ? 1 : 0)
                }
                .onTapGesture { self.selectedColor = color }
                .frame(width: 30, height: 30)
            }
        }
        .padding()
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(selectedColor: .constant(.red))
    }
}
