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
    case appandTask(String)
    case doneButtonEnableChecker(Bool)
    case dismiss
  }
  
  struct State {
    var isEnableDoneButton: Bool = false
    var saveTaskName: String = ""
    var isDismiss: Bool = false
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .done:
      return Observable.concat([
        Observable.just(Mutation.userDefailtsSaveName),
        Observable.just(Mutation.dismiss)
      ])
      
    case .textFieldEditting(let isEditting):
      return Observable.just(Mutation.doneButtonEnableChecker(isEditting))
      
    case .saveTaskName(let taskName):
      return Observable.just(Mutation.appandTask(taskName))
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
      
    case .appandTask(let taskName):
      newstate.saveTaskName = taskName
      
    case .dismiss:
      newstate.isDismiss.toggle()
    }
    
    return newstate
  }
  
}
