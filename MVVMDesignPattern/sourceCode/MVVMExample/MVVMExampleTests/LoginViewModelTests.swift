//
//  LoginViewModelTests.swift
//  MVVMExampleTests
//
//  Created by 김광수 on 2021/05/11.
//

import XCTest
import Combine

@testable import MVVMExample
class LoginViewModelTests: XCTestCase {
    
//    var sut: LoginViewModel!
//    var cancellable: Set<AnyCancellable>!
//    
//    override func setUpWithError() throws {
//        sut = LoginViewModel()
//        cancellable = Set<AnyCancellable>()
//    }
//
//    override func tearDownWithError() throws {
//        sut = nil
//    }
//
//    func testLoginViewModel_WhenProvideEmptyEmail_ShouldReturnTrue() {
//        
//        // arrange
//        sut.email = ""
//        sut.password = "123213"
//        
//        // assert
//        sut.$isDisable
//            .sink { isDisable in
//                XCTAssertTrue(isDisable, "로그인 버튼 비활성화")
//            }.store(in: &cancellable)
//    }
//    
//    func testLoginViewModel_WhenProvideEmptyPassword_ShouldReturnTrue() {
//        // arrange
//        sut.email = "12321321"
//        sut.password = ""
//        
//        // assert
//        sut.$isDisable
//            .sink { isDisable in
//                XCTAssertTrue(isDisable, "로그인 버튼 비활성화")
//            }.store(in: &cancellable)
//    }
//    
//    func testLoginViewModel_WhenProviededPasswordAndEmail_ShoudlReturnFalse() {
//        // arrange
//        sut.email = "123213123"
//        sut.password = "123123123"
//        
//        sut.$isDisable
//            .sink { isDisable in
//                XCTAssertFalse(isDisable, "로그인 버튼 활성화")
//            }.store(in: &cancellable)
//    }
}
