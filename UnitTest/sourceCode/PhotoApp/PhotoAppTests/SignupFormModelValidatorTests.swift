//
//  SignupFormModelValidatorTests.swift
//  PhotoAppTests
//
//  Created by 김광수 on 2020/11/29.
//

import XCTest
@testable import PhotoApp

class SignupFormModelValidatorTests: XCTestCase {

    var sut: SignupFormModelValidator!
    
    override func setUp() {
        // 인스턴스 생성
        sut = SignupFormModelValidator()
    }
    
    override func tearDown() {
        // 메모리 제거
        sut = nil
    }
    
    func testSignupFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "Sergey")
        
        // Assert
        XCTAssertTrue(isFirstNameValid, "the isFirstNameValid() should have returned TRUE for a valid first Name")
    }
    
    func testSingupFormModelValidator_WhenTooShortFirstNameProvided_ShouldRetrunFalse() {
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "S")
        
        // Asset
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() Should have return FALSE for a first name that is shorter than \(SingupConstants.firstNameMinLength) characters but it has return TRUE")
    }
    
    func testSingupFormModelValidator_WhenTooLongFirstNameProvided_ShoudReturnFalse() {
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "SergeySergey") // 16
        
        // Asset
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() Shoud have return FALSE for a first naem that is Longer than \(SingupConstants.firstNameMaxLength) characters but in has return TRUE")
    }
}
