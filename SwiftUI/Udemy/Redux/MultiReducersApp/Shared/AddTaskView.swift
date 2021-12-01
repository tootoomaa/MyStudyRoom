//
//  AddTaskView.swift
//  MultiReducersApp
//
//  Created by 김광수 on 2021/12/01.
//

import SwiftUI

struct AddTaskView: View {
    
    @EnvironmentObject var store: Store<AppState> // root state add
    @State private var name: String = ""
    
    struct Props {
        // props
        var tasks: [Task]
        
        // dispatch
        var onTaskAdded: (Task) -> ()
    }
    
    private func map(state: TaskState) -> Props {
        return Props(tasks: state.tasks , onTaskAdded: { task in
            store.dispatch(action: AddTaskAction(task: task))
        })
    }
    
    var body: some View {
        
        let props = map(state: store.state.taskState)
        
        return VStack {
            
            TextField("Enter Task", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Add") {
                let newTask = Task(title: self.name)
                props.onTaskAdded(newTask)
            }
            
            List(props.tasks, id: \.id) { task in
                Text(task.title)
            }
            
            Spacer()
            
        }.padding()
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        
        let store = Store<AppState>(reducer: appReducer, state: AppState())
        AddTaskView()
            .environmentObject(store)
    }
}
