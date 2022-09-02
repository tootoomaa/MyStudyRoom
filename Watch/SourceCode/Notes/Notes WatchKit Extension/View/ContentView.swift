//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by 김광수 on 2022/09/01.
//

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTY
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    @AppStorage("lineCount") var lineCount: Int = 1
    
    //MARK: - Function
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        do {
            // 1. Convert the notes array to data using JSONEncoder
            let data = try JSONEncoder().encode(notes)
            // 2. Create a new URL to save the file the getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("notes")
            // 3. Write the data to the given URL
            try data.write(to: url)
        } catch {
            print("Saving data has failed")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                // 1. Get the notes URL path
                let url = self.getDocumentDirectory().appendingPathComponent("notes")
                // 2. Create a new properties fro the data
                let data = try Data(contentsOf: url)
                // 3. Decode the data
                self.notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                // Do nothing
            }
        }
    }
    
    func delete(offset: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offset)
            save()
        }
    }
    
    //MARK: - BODY
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                TextField("Tap To Input", text: $text)
                
                Button(action: {
                    // 1. Only run the button's action when the text field is not empty
                    guard text.isEmpty == false else { return }
                    // 2. create a new note item and initialize it with the text value
                    let note = Note(id: UUID(), text: text)
                    
                    // 3. Add the new note item to the notes array (append)
                    notes.append(note)
                    
                    // 4. Make the text field empty
                    text = ""
                    
                    // 5. Save the notes (function)
                    save()
                    
                }, label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .font(.system(size: 42, weight: .semibold))
                }) //: Button
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
            } //: HSTACK
            
            Spacer()
            
            if self.notes.count >= 1 {
                List {
                    ForEach(0..<self.notes.count, id: \.self) { i in
                        NavigationLink(destination: {
                            DetailNoteView(
                                note: self.notes[i],
                                count: self.notes.count,
                                index: i
                            )
                        }, label: {
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(self.notes[i].text)
                                    .lineLimit(lineCount)
                                    .padding(.leading, 4)
                            } //: HSTAKC
                        }) //: NavigationLink
                    } //: ForEach Loop
                    .onDelete(perform: delete)
                } //: List
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .foregroundColor(.gray)
                    .opacity(0.2)
                    .frame(width: 50, height: 50)
                    
                Spacer()
            }
        } //: VSATCK
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Notes")
        .onAppear(perform: load)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
