//
//  Store.swift
//  MultiReducersApp
//
//  Created by 김광수 on 2021/12/01.
//

import Foundation

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State


protocol ReduxState { }

struct AppState: ReduxState {
    var counterState = CounterState()
    var taskState = TaskState()
}

struct TaskState: ReduxState {
    var tasks: [Task] = [Task]()
}

struct CounterState: ReduxState {
    var counter: Int = 0
}

protocol Action { }

struct IncrementAction: Action { }
struct DecrementAction: Action { }
struct AddTaskAction: Action {
    let task: Task
}

struct AddAction: Action {
    let value: Int
}

class Store<StoreState: ReduxState>: ObservableObject {     // State의 변경을 View에 알리기 위해서 ObservableObject
    
    var reducer: Reducer<StoreState>
    @Published var state: StoreState     // Store는 State가 변경 되었을때 View에 알려야 함!
    
    init(reducer: @escaping Reducer<StoreState>, state: StoreState) {
        self.reducer = reducer
        self.state = state
    }
    
    func dispatch(action: Action) {
        state = reducer(state, action)
    }
}


