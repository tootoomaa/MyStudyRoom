//
//  SignupPresenterProtocol.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/12/05.
//

import Foundation

protocol SignupPresenterProcotol: AnyObject {
    
    init(formModelValidator: SignupModelValidatorProtocol,
         webservice: SignupWebServiceProtocol,
         delegate: SignupViewDelegateProtocol)
    
    func processUserSignup(formModel: SignupFormModel)
}
