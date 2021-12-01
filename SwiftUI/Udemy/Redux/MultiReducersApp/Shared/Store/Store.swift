//
//  Store.swift
//  MultiReducersApp
//
//  Created by 김광수 on 2021/12/01.
//

import Foundation

typealias Dispatcher = (Action) -> Void

typealias Reducer<State: ReduxState> = (_ state: State, _ action: Action) -> State
typealias Middleware<StoreState: ReduxState> = (StoreState, Action, @escaping Dispatcher) -> Void

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

struct IncrementActionAsync: Action { }

struct AddTaskAction: Action {
    let task: Task
}

struct AddAction: Action {
    let value: Int
}

class Store<StoreState: ReduxState>: ObservableObject {     // State의 변경을 View에 알리기 위해서 ObservableObject
    
    var reducer: Reducer<StoreState>
    @Published var state: StoreState                        // Store는 State가 변경 되었을때 View에 알려야 함!
    var middlewares: [Middleware<StoreState>]
    
    init(reducer: @escaping Reducer<StoreState>, state: StoreState, middlewares: [Middleware<StoreState>] = []) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }
    
    func dispatch(action: Action) {
        
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
        
        // run all middlewares
        middlewares.forEach { middleware in
            middleware(state, action, dispatch)
        }
    }
}


