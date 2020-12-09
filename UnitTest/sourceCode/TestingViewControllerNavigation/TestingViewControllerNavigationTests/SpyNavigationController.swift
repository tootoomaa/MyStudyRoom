//
//  SpyNavigationController.swift
//  TestingViewControllerNavigationTests
//
//  Created by 김광수 on 2020/12/08.
//

import Foundation
import UIKit

class SpyNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        pushedViewController = viewController
    }
    
}
