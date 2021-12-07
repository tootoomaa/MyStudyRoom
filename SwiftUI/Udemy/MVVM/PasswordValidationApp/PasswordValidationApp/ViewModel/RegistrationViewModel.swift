//
//  RegisterationViewModel.swift
//  PasswordValidationApp
//
//  Created by 김광수 on 2021/12/07.
//

import Foundation
import Combine


/// brokenRules 변수를 외부로부터 숨김
class ValidationBase: ObservableObject {
    @Published fileprivate (set) var brokenRules: [BrokenRule] = [BrokenRule]()
}

protocol Validator: ValidationBase {
    func validate()
}

extension Validator {
    func addBrockenRule(_ rule: BrokenRule) {
        brokenRules.append(rule)
    }
    
    func clearBrockenRules() {
        brokenRules = []
    }
}

class RegisterationViewModel: ValidationBase {
    var firstname: String = ""
    var lastname: String = ""
    var username: String = ""
    var password: String = ""
}

extension RegisterationViewModel: Validator {
    func validate() {
        clearBrockenRules()
        
        if firstname.isEmpty {
            addBrockenRule(BrokenRule(name: "firstname", message: "Firstname should not be empty"))
        }
        
        if lastname.isEmpty {
            addBrockenRule(BrokenRule(name: "lastname", message: "Lastname should not be empty"))
        }
    }
}
