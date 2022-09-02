//
//  DetailNoteView.swift
//  Notes WatchKit Extension
//
//  Created by 김광수 on 2022/09/02.
//

import SwiftUI

struct DetailNoteView: View {
    
    let note: Note
    let count: Int
    let index: Int
    @State private var isPresentCreditView: Bool = false
    @State private var isPresentSettingsView: Bool = false
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 4) {
            NoteWithLineView(title: nil)
            
            ScrollView(.vertical) {
                Text(note.text)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            HStack {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture { isPresentSettingsView.toggle() }
                    .sheet(isPresented: $isPresentSettingsView) {
                        Settings()
                    }
                
                Spacer()
                
                Text("\(index+1) / \(count)")
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture { isPresentCreditView.toggle() }
                    .sheet(isPresented: $isPresentCreditView) {
                        CreditView()
                    }
            } //: HSTACK
            .foregroundColor(.accentColor)
        } //: VSTACK
        
    }
}

struct DetailNoteView_Previews: PreviewProvider {
    static var previews: some View {
        let note = Note(
            id: UUID(),
            text: "This is text note. Let's create a new application with SwiftUI framework for Apple Watch App"
        )
        DetailNoteView(
            note: note,
            count: 3,
            index: 1
        )
    }
}
