//
//  ContentView.swift
//  Shared
//
//  Created by 김광수 on 2021/12/01.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    @EnvironmentObject var store: Store<AppState> // root state add
    
    /*
     Store.counter 를 이용할수도 있지만
     추후 store가 많아질 경우 관리가 어려워질수 있기 때문에
     로컬 프로퍼티 Struct를 만들어서 연결한다.
     
     state의 변경은 view의 변경에 영향을 미치므로 최소한의 값만 binding 해준다.
     */
    struct Props {
        let counter: Int
        let onIncrement: () -> Void
        let onDecrement: () -> Void
        let onAddAction: (Int) -> Void
        let onIncrementAsync: () -> Void
    }
    
    /// View에 영향을 주는 변수들과 Store의 값을 binding
    /// - Parameter state: State
    /// - Returns: View에서 사용될 변수 리턴
    private func map(state: CounterState) -> Props {
        Props(counter: state.counter, onIncrement: {
            store.dispatch(action: IncrementAction())
        }, onDecrement: {
            store.dispatch(action: DecrementAction())
        }, onAddAction: {
            store.dispatch(action: AddAction(value: $0))
        }, onIncrementAsync: {
            store.dispatch(action: IncrementActionAsync())
        })
    }
    
    var body: some View {
        
        let props = map(state: store.state.counterState)
        
        VStack {
            Text("\(props.counter)")
                .padding()
            
            Button("Increment")         { props.onIncrement() }
            Button("Decrement")         { props.onDecrement() }
            Button("Add")               { props.onAddAction(100) }
            Button("Increment Async")   { props.onIncrementAsync() }
            
            Spacer()
            
            Button("Add Task") {
                isPresented = true
            }
            
            Spacer()
        }
        .sheet(isPresented: $isPresented) {
            AddTaskView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let store = Store(reducer: counterReducer, state: CounterState())
        
        ContentView()
            .environmentObject(store)
    }
}
