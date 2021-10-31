//
//  Router.swift
//  VIPER_DesignPattern
//
//  Created by 김광수 on 2021/10/31.
//

import Foundation
import UIKit

// Object
// Entry Point

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint?  { get }
    
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        // Assing VIP
        var view: EntryPoint = UserViewController()
        var presentor: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presentor = presentor
        
        interactor.presentor = presentor
        
        presentor.view = view
        presentor.router = router
        presentor.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
