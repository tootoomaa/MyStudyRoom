//
//  AppReducer.swift
//  MultiReducersApp
//
//  Created by 김광수 on 2021/12/01.
//

import Foundation

func appReducer(_ state: AppState, _ action: Action) -> AppState {
    
    var state = state
    
    state.counterState = counterReducer(state.counterState, action)
    state.taskState = taskReducer(state.taskState, action)
    
    return state
}
