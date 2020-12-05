//
//  MockSignupPresenter.swift
//  PhotoAppTests
//
//  Created by 김광수 on 2020/12/05.
//

import Foundation
@testable import PhotoApp

class MockSignupPresenter: SignupPresenterProcotol {
    
    var processUserSignupCalled: Bool = false
    
    required init(formModelValidator: SignupModelValidatorProtocol, webservice: SignupWebServiceProtocol, delegate: SignupViewDelegateProtocol) {
        // TODO:
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        processUserSignupCalled = true
    }
}
