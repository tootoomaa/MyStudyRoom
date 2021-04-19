//
//  UserViewModel.swift
//  TextFieldExample
//
//  Created by 김광수 on 2021/04/19.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    // Input
    @Published var username = ""
    @Published var password = ""
    @Published var passwordAgain = ""
    @Published var passwordMessage: String = ""
    
    // Output
    @Published var isValid = false
    
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {
        
        isPasswordValidPublisher
            .receive(on: RunLoop.main)
            .map { passwordCheck in
                switch passwordCheck {
                case .empty:
                    return "Password must not be empty"
                case .noMatch:
                    return "Passwords don't match"
                case .notStrongEnough:
                    return "Password not strong enough"
                case .userNameEmpty:
                    return "User Name Emtpy"
                default:
                    return ""
                }
            }
            .assign(to: \.passwordMessage, on: self)
            .store(in: &cancellableSet)
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
}

// MARK: - User Name Valide
extension UserViewModel {
    
    var userNameEmptyPublisher: AnyPublisher<Bool, Never> {
        $username
            .map { username in
                return username != ""
            }
            .eraseToAnyPublisher()
    }
    
}

// MARK: - Password Valid
extension UserViewModel {
    
    enum PasswordCheck {
        case userNameEmpty
        case valid
        case empty
        case noMatch
        case notStrongEnough
    }
    
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        // (1)
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { password in
                return password == ""
            }
            .eraseToAnyPublisher()
    }
    
    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordAgain)
            .map { password, passwordAgain in
                return password == passwordAgain
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordStringEnoughPulbisher: AnyPublisher<Bool, Never> {
        
        Publishers.CombineLatest($password, $passwordAgain)
            .map { password, passwordAgain in
                return password.count > 5 && passwordAgain.count > 5
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordValidPublisher: AnyPublisher<PasswordCheck, Never> {
        Publishers.CombineLatest4(userNameEmptyPublisher,
                                  isPasswordEmptyPublisher, arePasswordsEqualPublisher, isPasswordStringEnoughPulbisher)
            .map { usernameEmpty, passwordIsEmpty, passwordsAreEqual, passwordIsStrongEnough in
                if !usernameEmpty {
                    return .userNameEmpty
                } else if (passwordIsEmpty) {
                    return .empty
                } else if (!passwordsAreEqual) {
                    return .noMatch
                } else if (!passwordIsStrongEnough) {
                    return .notStrongEnough
                } else {
                    return .valid
                }
            }
            .eraseToAnyPublisher()
    }
    
}

// MARK: - form Validated
extension UserViewModel {
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(userNameEmptyPublisher, isPasswordValidPublisher)
            .map { usernameIsValid, passwordIsValid in
                return usernameIsValid && (passwordIsValid == .valid)
            }
            .eraseToAnyPublisher()
    }
    
}
