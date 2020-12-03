//
//  MockSignupWebService.swift
//  PhotoAppTests
//
//  Created by 김광수 on 2020/12/02.
//

import Foundation
@testable import PhotoApp

class MockSignupWebService: SignupWebServiceProtocol {
    
    var isSignupMethodCalled: Bool = false
    var shouldReturnError: Bool = false
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        
        isSignupMethodCalled = true
        
        if shouldReturnError == false {
            // success
            let reponseModel = SignupResponseModel(status: "Ok")
            completionHandler(reponseModel, nil)
        } else {
            // failure
            completionHandler(nil, SignupError.invalidResponseModel)
        }
    }
    
}
