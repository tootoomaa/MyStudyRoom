//
//  BaseService.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/04/01.
//

import Foundation

class BaseService {
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
}
