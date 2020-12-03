//
//  SingupWebServiceProtocol.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/12/02.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)
}
