//
//  TaskAddViewController.swift
//  MyRxTodoApp
//
//  Created by 김광수 on 2020/12/19.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import ReactorKit

enum TaskModifyType: String {
  case new
  case edit
}

class TaskModifyViewController: UIViewController, View {
  
  var disposeBag = DisposeBag()
  let taskModifyView = TaskModifyView()
  var taskModifyType: TaskModifyType?
  
  let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
  let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil).then {
    $0.isEnabled = false
  }
  
  // MARK: - Initialization
  
  init(_ reactor: TaskModifyViewControllerReactor,
       _ taskModifyType: TaskModifyType) {
    super.init(nibName: nil, bundle: nil)
    self.title = taskModifyType.rawValue
    self.navigationItem.leftBarButtonItem = cancelButton
    self.navigationItem.rightBarButtonItem = doneButton
    self.reactor = reactor
    self.taskModifyType = taskModifyType
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Load
  override func loadView() {
    view = taskModifyView
  }
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  func bind(reactor: TaskModifyViewControllerReactor) {
    
    // Action
    self.doneButton.rx.tap
      .map { Reactor.Action.done }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    self.cancelButton.rx.tap
      .subscribe(onNext: {
        self.dismiss(animated: true, completion: nil)
      }).disposed(by: disposeBag)

    self.taskModifyView.taskTextField.rx.text
      .map { Reactor.Action.textFieldEditting($0?.isEmpty ?? false)}
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    self.taskModifyView.taskTextField.rx.text
      .map { Reactor.Action.saveTaskName($0 ?? "") }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    // State
    reactor.state.map { $0.isEnableDoneButton }
      .bind(to: self.doneButton.rx.isEnabled)
      .disposed(by: disposeBag)
    
  }
  
}
