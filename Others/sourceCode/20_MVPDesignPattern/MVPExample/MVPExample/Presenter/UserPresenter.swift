//
//  UserPresenter.swift
//  MVPExample
//
//  Created by 김광수 on 2020/11/21.
//

import Foundation
// User Data를 View에서 보여줄 데이터로 변환하기 위한 데이터셋
struct UserViewData {
  let name: String
  let age: String
}

// [View의 추상화 작업을 진행]
// 프로토콜을 통해 Presenter가 ViewController를 알지 못해도
// View 작업을 수행할수 있도록 한다
protocol UserView {
  func startLoading()
  func finishLoading()
  func setUsers(users: [UserViewData])
  func setEmptyUsers()
}

class UserPresenter {
  private let userService: UserService
  private var userView: UserView?
  
  init(userService: UserService) {
    self.userService = userService
  }
  
  func attachView(view: UserView) {
    userView = view
  }
  
  func detachView() {
    userView = nil
  }
  
  func getUsers() {
    userView?.startLoading()
    userService.getUsers { [weak self] users in
      DispatchQueue.main.async {
        self?.userView?.finishLoading()
      }
      
      guard !users.isEmpty else {
        DispatchQueue.main.async {
          // 사용자 데이터를 UI에 적용하기 때문에 main 큐에서 적용
          self?.userView?.setEmptyUsers()
        }
        
        return
      }
      
      let userViewDatas = users.map {
        // 화면에 보여줄 데이터로 전환
        UserViewData(name: "Mr. \($0.name)", age:"\($0.age) years")  }
      DispatchQueue.main.async {
        // 사용자 데이터를 UI에 적용하기 때문에 main 큐에서 적용
        self?.userView?.setUsers(users: userViewDatas)
      }
    }
  }
}
