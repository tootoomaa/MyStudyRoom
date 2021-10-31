//
//  Router.swift
//  CoordinatorTest
//
//  Created by 김광수 on 2021/10/31.
//

import Foundation

protocol Router: class {
    func show(_ viewController: UIViewController, animated: Bool)
    func hide(animated: Bool)
}
