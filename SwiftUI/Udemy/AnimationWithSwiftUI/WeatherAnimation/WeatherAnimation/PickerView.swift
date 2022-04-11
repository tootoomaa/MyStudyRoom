//
//  PickerView.swift
//  WeatherAnimation
//
//  Created by 김광수 on 2022/04/09.
//

import SwiftUI

struct PickerView: View {
    
    @Binding var pickerSelection: Int
    
    var body: some View {
        Picker(selection: self.$pickerSelection) {
            Text("Temperature🌡").tag(0)
            Text("Precipitation🌨").tag(1)
            Text("Wind💨").tag(2)
        } label: {
            Text("")
        } //: Picker
        .pickerStyle(SegmentedPickerStyle())
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 2)
                .shadow(color: Color.black, radius: 8, x: 0, y: 0)
        )
        .cornerRadius(8)
        .padding(.horizontal, 10)
        .padding(.bottom, 10)

    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(pickerSelection: .constant(1))
            .previewLayout(.fixed(width: 350, height: 100))
    }
}
