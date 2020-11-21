//
//  AppDelegate.swift
//  MVPExample
//
//  Created by 김광수 on 2020/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  
    window = UIWindow(frame: UIScreen.main.bounds)
    
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
    
    return true
  }

}

