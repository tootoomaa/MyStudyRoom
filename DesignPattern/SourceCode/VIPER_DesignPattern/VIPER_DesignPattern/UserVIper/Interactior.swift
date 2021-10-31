//
//  Interactior.swift
//  VIPER_DesignPattern
//
//  Created by 김광수 on 2021/10/31.
//

import Foundation

// object
// protocol
// ref to preseter

// https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presentor: AnyPresenter?        { get set }
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presentor: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            guard let data = data else {
                self.presentor?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entity = try JSONDecoder().decode([User].self, from: data)
                self.presentor?.interactorDidFetchUsers(with: .success(entity))
            } catch {
                print(error)
                self.presentor?.interactorDidFetchUsers(with: .failure(FetchError.failed))
            }

        }.resume()
    }
}
