//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by 김광수 on 2020/12/02.
//

import Foundation

class SignupPresenter: SignupPresenterProcotol {
    
    private var formModelValidator: SignupModelValidatorProtocol
    private var webservice: SignupWebServiceProtocol
    private weak var delegate: SignupViewDelegateProtocol?
    
    required init(formModelValidator: SignupModelValidatorProtocol,
         webservice: SignupWebServiceProtocol,
         delegate: SignupViewDelegateProtocol) {
        
        self.formModelValidator = formModelValidator
        self.webservice = webservice
        self.delegate = delegate
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        
        if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
            delegate?.errrorHandler(error: SignupError.invalidFirstName)
            return
        }
        
        if !formModelValidator.isLastNameValid(lastName: formModel.lastName) {
            delegate?.errrorHandler(error: SignupError.invalidLastName)
            return
        }
        
        if !formModelValidator.isEmailValid(email: formModel.email) {
            delegate?.errrorHandler(error: SignupError.invalidEmail)
            return
        }
        
        if !formModelValidator.isPasswordValid(passwd: formModel.password) {
            delegate?.errrorHandler(error: SignupError.invalidPassword)
            return
        }
        
        if !formModelValidator.doPasswordMatch(password: formModel.password, repeatPassword: formModel.repeatPassword) {
            delegate?.errrorHandler(error: SignupError.invalidRepeatPassword)
            return
        }
        
        let requestModel = SignupFormRequestModel(firstName: formModel.firstName, lastName: formModel.lastName,
                                                  email: formModel.email, password: formModel.password)
        
        webservice.signup(withForm: requestModel) { (reponseModel, error) in
            // TODO
            if let _ = reponseModel {
                self.delegate?.successfulSignup()
            } else {
                self.delegate?.errrorHandler(error: .invalidResponseModel)
            }
            return
        }
    }
    
}
