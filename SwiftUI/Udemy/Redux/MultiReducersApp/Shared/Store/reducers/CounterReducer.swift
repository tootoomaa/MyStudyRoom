//
//  CounterReducer.swift
//  MultiReducersApp
//
//  Created by 김광수 on 2021/12/01.
//

import Foundation

func counterReducer(_ state: CounterState, _ action: Action) -> CounterState {
    
    var state = state
    
    switch action {
    case _ as IncrementAction:          state.counter += 1
    case _ as DecrementAction:          state.counter -= 1
    case let action as AddAction:       state.counter += action.value
    default:                            break
    }
    
    return state
}
