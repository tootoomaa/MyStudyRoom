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
}

// MARK: - First Name Validator
extension SignupFormModelValidatorTests {
    
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
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() Should have return FALSE for a first name that is shorter than \(SignupConstants.firstNameMinLength) characters but it has return TRUE")
    }
    
    func testSingupFormModelValidator_WhenTooLongFirstNameProvided_ShoudReturnFalse() {
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "SergeySergey") // 10
        
        // Asset
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() Shoud have return FALSE for a first naem that is Longer than \(SignupConstants.firstNameMaxLength) characters but in has return TRUE")
    }
    
}

// MARK: - Last Name Validator
extension SignupFormModelValidatorTests {
    
    func testSignupFormModelValidator_WhenValidLastNameProvieded_ShouldReturnTrue() {
        
        let isLastNameValid = sut.isLastNameValid(lastName: "Sergey")
        
        XCTAssertTrue(isLastNameValid, "the isLastName() shoud return TRUE when LastName is a valid")
        
    }
    
    func testSingupFormModelValidator_WhenTooShorLastNameProvided_ShouldRetrunFalse() {
        // Act
        let isLastNameValid = sut.isLastNameValid(lastName: "Sy")
        
        // Assert
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() Shoud have return FALSE for a last name that is smaller than \(SignupConstants.lastNameMinLength) characters but in has return TRUE")
    }
    
    func testSignupFormModelValidator_WhenTooLongLastNameProvided_ShouldReturnFalse() {
        // Act
        let isLastNameValid = sut.isFirstNameValid(firstName: "SergeySergey")
        
        // Assert
        XCTAssertFalse(isLastNameValid, "The isLastNameValid() Should have return FASLE for a last name that is Shoter than \(SignupConstants.lastNameMaxLength) characters but in has return TRUE")
    }
}

// MARK: - Email Validator
extension SignupFormModelValidatorTests {
    
    func testSignupFormModelValidator_WhenValidEmailProvieded_ShouldReturnTrue() {
        
        // Act
        let isEmailValid = sut.isEmailValid(email: "tootoomaa@gamil.com")
        
        // Assert
        XCTAssertTrue(isEmailValid, "The isEmailValid() should return True when valid email format provieded")
        
    }
    
    func testSignupFormatModelValidator_WhenNotIncludeSepcialChar_ShouldReturnFalse() {
        
        // Act
        let isEmailValid = sut.isEmailValid(email: "tootoomagamil.com")
        
        // Assert
        XCTAssertFalse(isEmailValid, "The isEmailValid() should return False when Email not include @")
        
    }
    
    func testSignupFormModelValidator_WhenNotIncludeDot_ShouldReturnFalse() {
        
        // Act
        let isEmailValid = sut.isEmailValid(email: "tootoomaa@gmailcom")
        
        // Assert
        XCTAssertFalse(isEmailValid, "The isEmailValid() shoud return False when Email not include .")
    }
}

// MARK: - Password Validator
extension SignupFormModelValidatorTests {
    
    func testSignupFormModelValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        
        // Act
        let isPasswordValid = sut.isPasswordValid(passwd: "Testtest1!")
        
        //Assert
        XCTAssertTrue(isPasswordValid, "The isPassword() should return TRUE when Password is valid")
    }

    func testSignupFormModelValidator_WhenTooShortPWProvided_ShouldRetuenFalse() {
        
        // Act
        let isPasswordValid = sut.isPasswordValid(passwd: "testes")
        
        //Assert
        XCTAssertFalse(isPasswordValid, "the isPasswordValid should return FALSE When input Password is Too Short, \(SignupConstants.passwordMinLength) charactor is MIN Password Count")
        
    }
    
    func testSignFormModelValidator_WhenTooLongPWProvided_ShouldReturnFalse() {
        
        // Act
        let isPasswordValid = sut.isPasswordValid(passwd: "testtesttesttesttest")
        
        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid should return FALSE When input Password is Too Long, \(SignupConstants.passwordMaxLength) charactor is MAX Password Count")
    }
    
    func testSignupFormModelValidator_WhenEqualPasswordsProvided_ShoudReturnTrue() {
        
        // Act
        let isPasswordValid = sut.doPasswordMatch(password: "12345678", repeatPassword: "12345678")
        
        // Assert
        XCTAssertTrue(isPasswordValid, "The isPassworValid() shoud return TRUE When Two Password are Equal")
    }
    
    func testSignupFormModelValidator_WhenNotMatchingPasswordsProvided_ShouldReturnFail() {
        
        // Act
        let isPasswordValid = sut.doPasswordMatch(password: "12345678", repeatPassword: "123456")
        
        XCTAssertFalse(isPasswordValid, "isPasswordValid() 함수는 입력된 두 패스워드가 같지 않을때 FALSE 를 리턴합니다. 입력된 두 패스워드가 같다면 TRUE 를 리턴 할 것입니다.")
    }
}
