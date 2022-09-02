//
//  Settings.swift
//  Notes WatchKit Extension
//
//  Created by 김광수 on 2022/09/02.
//

import SwiftUI

struct Settings: View {
    //MARK: - Properties
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    //MARK: - body
    var body: some View {
        VStack(spacing: 8) {
            NoteWithLineView(title: "SETTINGS")
            
            Slider(value: $value, in: 1...4, step: 1)
                .foregroundColor(.accentColor)
            
            Text("Lines \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            Spacer()
        } //: VSTACK
        .onAppear {
            self.value = Float(lineCount)
        }
        .onChange(of: value) { newValue in
            self.lineCount = Int(newValue)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
