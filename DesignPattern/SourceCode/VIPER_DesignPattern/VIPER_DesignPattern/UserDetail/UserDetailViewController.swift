//
//  UserDetailViewController.swift
//  VIPER_DesignPattern
//
//  Created by 김광수 on 2021/10/31.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController, AnyView {
    var presentor: AnyPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func update(with users: [User]) {
        <#code#>
    }
    
    func update(with error: String) {
        <#code#>
    }
}
