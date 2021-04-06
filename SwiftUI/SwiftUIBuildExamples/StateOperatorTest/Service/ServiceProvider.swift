//
//  ServiceProvider.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import Foundation

protocol ServiceProviderType {
    var userService: UserServiceType { get }
    var newsService: GoodNewsServiceType { get }
}

class ServiceProvider: ServiceProviderType, ObservableObject {
    lazy var userService: UserServiceType = UserServcie(provider: self)
    lazy var newsService: GoodNewsServiceType = GoodNewsService(provider: self)
}
