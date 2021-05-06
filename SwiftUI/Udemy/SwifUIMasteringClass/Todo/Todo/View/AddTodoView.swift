//
//  AddTodoView.swift
//  Todo
//
//  Created by 김광수 on 2021/05/06.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: - TODO NAME
                    Text("Hello, World!")
                    
                    // MARK: - TODO Priotiry
                    Picker("Priorities", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // MARK: - Save Button
                    Button(action: {
                        print("Save a new todo list")
                        
                        let todo = Todo(context: self.managedObjectContext)
                        todo.name = self.name
                        todo.priority = self.priority
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                        
                    }, label: {
                        Text("save")
                    })
                    
                } //: Form
                Spacer()
                
            } //: VSTACK
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            )
        } //: Navigation
        .navigationBarTitle("New Todo", displayMode: .inline)
    }
}

// MARK: - Preview
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
