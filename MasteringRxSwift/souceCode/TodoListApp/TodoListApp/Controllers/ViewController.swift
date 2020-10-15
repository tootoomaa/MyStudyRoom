//
//  ViewController.swift
//  TodoListApp
//
//  Created by 김광수 on 2020/10/15.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  let disposeBag = DisposeBag()
  
  private var filteredTasks = [Task]()
  
  private var tasks = BehaviorRelay<[Task]>(value: [])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @IBAction func tapSegmentedControlButton() {
    let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
    filterTasks(by: priority)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let navC = segue.destination as? UINavigationController,
          let taskAddVC = navC.viewControllers.first as? AddNewTaskViewController else { fatalError("Can't find taskAddVC") }
    
    taskAddVC.taskSubjectObservavle
      .subscribe(onNext: {
        
        let priority = Priority(rawValue: self.segmentedControl.selectedSegmentIndex-1)
        
        var existingTasks = self.tasks.value // BehaviorRelay에 직접 추가 불가
        existingTasks.append($0)
        
        self.tasks.accept(existingTasks)
        self.filterTasks(by: priority)
        
      }).disposed(by: disposeBag)
  }
  
  private func filterTasks(by priority: Priority?) {
    
    if priority == nil {
      self.filteredTasks = self.tasks.value
      updateTableView()
    } else {

      self.tasks.map { tasks in
        return tasks.filter { $0.priority == priority! }
      }.subscribe(onNext: { [weak self] tasks in
        self?.filteredTasks = tasks
        self?.updateTableView()
      }).disposed(by: disposeBag)
      
    }
  }
  
  private func updateTableView() {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredTasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
    cell.textLabel?.text = filteredTasks[indexPath.row].title
    return cell
  }
}

