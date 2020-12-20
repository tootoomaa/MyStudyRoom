//
//  TaskModifyViewControllerReactor.swift
//  MyRxTodoApp
//
//  Created by 김광수 on 2020/12/20.
//

import Foundation
import RxSwift
import RxCocoa
import ReactorKit

class TaskModifyViewControllerReactor: Reactor {
  
  var initialState: State = State()
  var userDefaultService: UserDefaultsService
  var taskList: [String]
  
  init(_ userDefaultService: UserDefaultsService,
       _ taskList: [String]) {
    self.userDefaultService = userDefaultService
    self.taskList = taskList
  }
  
  enum Action {
    case done
    case textFieldEditting(Bool)
    case saveTaskName(String)
  }
  
  enum Mutation {
    case userDefailtsSaveName
    case saveTaskName(String)
    case doneButtonEnableChecker(Bool)
  }
  
  struct State {
    var isEnableDoneButton: Bool = false
    var saveTaskName: String = ""
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .done:
      return Observable.just(Mutation.userDefailtsSaveName)
    case .textFieldEditting(let isEditting):
      return Observable.just(Mutation.doneButtonEnableChecker(isEditting))
      
    case .saveTaskName(let taskName):
      return Observable.just(Mutation.saveTaskName(taskName))
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newstate = state
    
    switch mutation {
    case .userDefailtsSaveName:
      taskList.append(newstate.saveTaskName)
      userDefaultService.set(value: taskList)
      
    case .doneButtonEnableChecker(let isEnable):
      newstate.isEnableDoneButton = !isEnable
      
    case .saveTaskName(let taskName):
      newstate.saveTaskName = taskName
    }
    
    return newstate
  }
  
}
