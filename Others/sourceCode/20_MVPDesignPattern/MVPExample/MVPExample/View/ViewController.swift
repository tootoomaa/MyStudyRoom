//
//  ViewController.swift
//  MVPExample
//
//  Created by 김광수 on 2020/11/21.
//

import UIKit

class ViewController: UIViewController {
  
  let tableView = UITableView()
  let activityIndicator = UIActivityIndicatorView()
  
  // UserPresenter 인스턴스 생성
  private let userPresenter = UserPresenter(userService: UserService())
  // 화면에 표현할 데이터 셋
  private var userToDisplay = [UserViewData]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    
    // ViewController에 UserView 주입
    // 하단의 UserView Extension을 통해 UserView관련 함수 실행 by Protocol
    userPresenter.attachView(view: self)
    // 사용자 데이터 Fetch -> setUsers() 함수 부분으로 데이터 전달됨
    userPresenter.getUsers()
    
  }
  
  private func configureUI() {
    tableView.dataSource = self
    activityIndicator.hidesWhenStopped = true
    
    [tableView, activityIndicator].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let guid = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: guid.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: guid.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}

extension ViewController: UserView {
  func startLoading() {
    activityIndicator.startAnimating()
  }
  
  func finishLoading() {
    activityIndicator.stopAnimating()
  }
  
  // 사용자 데이터가 전달된 후 실행되는 함수
  func setUsers(users: [UserViewData]) {
    userToDisplay = users
    
    tableView.isHidden = false
    tableView.reloadData()
  }
  
  func setEmptyUsers() {
    tableView.isHidden = true
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userToDisplay.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "UserCell")
    
    cell.textLabel?.text = userToDisplay[indexPath.row].name
    cell.detailTextLabel?.text = userToDisplay[indexPath.row].age
    
    return cell
  }
}
