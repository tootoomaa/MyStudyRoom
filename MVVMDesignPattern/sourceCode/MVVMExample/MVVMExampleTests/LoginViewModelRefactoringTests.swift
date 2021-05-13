//
//  LoginViewModelRefactoringTests.swift
//  MVVMExampleTests
//
//  Created by 김광수 on 2021/05/12.
//

import XCTest
import Combine

@testable import MVVMExample
class LoginViewModelRefactoringTests: XCTestCase {
    
    var sut: LoginViewModel!
    var cancellable: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        sut = LoginViewModel()
        cancellable = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoginViewModel_WhenProvideEmptyEmail_ShouldReturnTrue() {
        
        // arrange
        sut.input.email = ""
        sut.input.password = "123213"
        
        // assert
        sut.output.$isDisable
            .sink { isDisable in
                XCTAssertTrue(isDisable, "로그인 버튼 비활성화")
            }.store(in: &cancellable)
    }
    
    func testLoginViewModel_WhenProvideEmptyPassword_ShouldReturnTrue() {
        // arrange
        sut.input.email = "12321321"
        sut.input.password = ""
        
        // assert
        sut.output.$isDisable
            .sink { isDisable in
                XCTAssertTrue(isDisable, "로그인 버튼 비활성화")
            }.store(in: &cancellable)
    }
    
    func testLoginViewModel_WhenProviededPasswordAndEmail_ShoudlReturnFalse() {
        // arrange
        sut.input.email = "123213123"
        sut.input.password = "123123123"
        
        sut.output.$isDisable
            .sink { isDisable in
                XCTAssertFalse(isDisable, "로그인 버튼 활성화")
            }.store(in: &cancellable)
    }
}
