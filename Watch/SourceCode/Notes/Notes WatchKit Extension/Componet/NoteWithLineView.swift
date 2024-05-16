//
//  NoteWithLineView.swift
//  Notes WatchKit Extension
//
//  Created by 김광수 on 2022/09/02.
//

import SwiftUI

struct NoteWithLineView: View {
    
    let title: String?
    
    var body: some View {
        VStack {
            
            if let title = title {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.accentColor)
            }
            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.accentColor)
                
                Image(systemName: "note.text")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.accentColor)
                    .padding(2)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.accentColor)
            } //: HSTACK
        } //: VSTACK
    }
}

struct NoteWithLineView_Previews: PreviewProvider {
    static var previews: some View {
        NoteWithLineView(title: "Credit")
    }
}
