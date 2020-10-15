//
//  AddNewTaskViewController.swift
//  TodoListApp
//
//  Created by 김광수 on 2020/10/15.
//

import UIKit
import RxSwift

class AddNewTaskViewController: UIViewController {
  
  @IBOutlet weak var prioritySegmentedContoller: UISegmentedControl!
  @IBOutlet weak var taskTitleTextField: UITextField!
  
  var taskSubject = PublishSubject<Task>()
  
  var taskSubjectObservavle: Observable<Task> {
    return taskSubject.asObservable()
  }
  
  @IBAction func tapSaveButton() {
    
    guard let priority = Priority(rawValue: self.prioritySegmentedContoller.selectedSegmentIndex),
          let taskTitle = taskTitleTextField.text else { return }
    
    let task = Task(title: taskTitle, priority: priority)
    
    taskSubject.onNext(task)
    
    dismiss(animated: true, completion: nil)
  }
}
