//
//  AppDelegate.swift
//  MyRxTodoApp
//
//  Created by 김광수 on 2020/12/19.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let taskListViewControllerReactor = TaskListViewControllerReactor()
    
    let taskListViewController = TaskListViewController(reactor: taskListViewControllerReactor)
    
    let naviVC = UINavigationController(rootViewController: taskListViewController)
    
    window?.rootViewController = naviVC
    
    window?.makeKeyAndVisible()
    
    return true
  }

}

