//
//  TaskListViewController.swift
//  MyRxTodoApp
//
//  Created by 김광수 on 2020/12/19.
//

import UIKit
import ReactorKit
import Then
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController, View {

  var disposeBag: DisposeBag = DisposeBag()
  let tableView = UITableView().then {
    $0.allowsSelectionDuringEditing = true
  }
  
  let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
  let newButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
  let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)
  
  // MARK: - Initialization
  init(reactor: TaskListViewControllerReactor) {
    super.init(nibName: nil, bundle: nil)
    self.navigationItem.leftBarButtonItems = [editButton, newButton]
    self.navigationItem.rightBarButtonItem = addButton
    self.reactor = reactor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(tableView)
    tableView.frame = view.bounds
    tableView.register(TaskTableViewCell.self,
                       forCellReuseIdentifier: TaskTableViewCell.identifier)
    
//    let tasks = ["Buy Apple", "Buy Banana"]
//    let userDefaultsService = UserDefaultsService()
//    userDefaultsService.set(value: tasks)
    
  }

  func bind(reactor: TaskListViewControllerReactor) {
    // Action
    self.rx.viewDidLoad
      .map { Reactor.Action.loadTask }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    addButton.rx.tap
      .map { Reactor.Action.tapAddButton }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    newButton.rx.tap
      .subscribe(onNext: {
        
        let backbuttonImage = UIImage(systemName: "arrowshape.turn.up.left.fill")
        let naviBar = self.navigationController?.navigationBar
        naviBar?.topItem?.title = ""
        naviBar?.backIndicatorImage = backbuttonImage
        naviBar?.backIndicatorTransitionMaskImage = backbuttonImage
        
        naviBar?.tintColor = .black
//        let backButtonItem = UIBarButtonItem(image: backbuttonImage, style: .plain, target: self, action: nil)
//        backButtonItem.tintColor = .black
//        self.navigationItem.backBarButtonItem = backButtonItem
        
        let webViewController = WebViewController()
        self.navigationController?.pushViewController(webViewController, animated: true)
        
      }).disposed(by: disposeBag)
    
//    editButton.rx.tap
//      .map { Reactor.Action.tapEditButton }
//      .bind(to: reactor.action)
//      .disposed(by: disposeBag)
    
    // reactor
    reactor.state.map { $0.tasks }
      .distinctUntilChanged()
      .debug()
      .bind(to: tableView.rx.items(
                cellIdentifier: TaskTableViewCell.identifier,
                cellType: TaskTableViewCell.self)) { row, task, cell in

        cell.textLabel?.text = task

      }.disposed(by: disposeBag)
    
    reactor.state.map { $0.taskAddVCMode }
      .subscribe(onNext: { [ weak self ] isEditing in
        
        guard let `self` = self,
              let isEditing = isEditing else { return }
        
        guard let tasks = self.reactor?.currentState.tasks else { return }
        let userDefaultsService = UserDefaultsService()
        let taskModifyVCReactor = TaskModifyViewControllerReactor(userDefaultsService, tasks)
        let taskModifyVC = TaskModifyViewController(taskModifyVCReactor, isEditing)
        
        let naviVC = UINavigationController(rootViewController: taskModifyVC)
        naviVC.modalPresentationStyle = .overFullScreen
        self.present(naviVC, animated: true)
        
      }).disposed(by: disposeBag)
    
  }
}


