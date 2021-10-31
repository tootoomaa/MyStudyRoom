//
//  Presenter.swift
//  VIPER_DesignPattern
//
//  Created by 김광수 on 2021/10/31.
//

import Foundation

// Object
// protocol
// ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter?          { get set }
    var interactor: AnyInteractor?  { get set }
    var view: AnyView?              { get set }
    
    func interactorDidFetchUsers(with: Result<[User], Error>)
}

class UserPresenter: AnyPresenter {
    var router: AnyRouter?
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getUsers()
        }
    }
    var view: AnyView?
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure(_):
            view?.update(with: "Fetch User Error")
        }
    }
}
