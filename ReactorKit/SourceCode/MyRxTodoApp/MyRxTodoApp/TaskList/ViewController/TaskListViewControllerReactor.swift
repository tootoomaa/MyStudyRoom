//
//  TaskListViewControllerReactor.swift
//  MyRxTodoApp
//
//  Created by 김광수 on 2020/12/19.
//

import Foundation
import ReactorKit
import RxSwift

class TaskListViewControllerReactor: Reactor {
  
  var initialState: State = State()
  let userDefaultsService = UserDefaultsService()
  
  enum Action {
    case loadTask
    case tapAddButton
    case tapEditButton
  }
  
  enum Mutation {
    case setTasks([String])
    case presentSwitchVC(TaskModifyType)
  }
  
  struct State {
    var tasks: [String] = []
    var taskAddVCMode: TaskModifyType?
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .loadTask:
      return userDefaultsService.value()
        .map { Mutation.setTasks($0) }
    case .tapEditButton:
      return Observable.just(Mutation.presentSwitchVC(.edit))
    case .tapAddButton:
      return Observable.just(Mutation.presentSwitchVC(.new))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    
    switch mutation {
    case .setTasks(let tasks):
      newState.tasks = tasks
    case .presentSwitchVC(let isEdit):
      newState.taskAddVCMode = isEdit
    }
    
    return newState
  }
}
