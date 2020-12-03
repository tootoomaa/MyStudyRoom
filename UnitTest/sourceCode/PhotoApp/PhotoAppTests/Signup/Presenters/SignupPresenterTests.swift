//
//  SignupPresenterTests.swift
//  PhotoAppTests
//
//  Created by 김광수 on 2020/12/02.
//

import XCTest
@testable import PhotoApp

class SignupPresenterTests: XCTestCase {
    
    var signupFormModel: SignupFormModel!
    var mockSignupModelValidator: MockSignupModelValidator!
    var mockSignupWebService: MockSignupWebService!
    var sut: SignupPresenter!
    var mockSignupViewDelegate: MockSignupViewDelegate!
    
    override func setUp() {
        // Arrage
        signupFormModel = SignupFormModel(firstName: "Sergay",
                                          lastName: "sdfkl",
                                          email: "test@test.com",
                                          password: "12345678",
                                          repeatPassword: "12345678")
        
        mockSignupModelValidator = MockSignupModelValidator()
        mockSignupWebService = MockSignupWebService()
        mockSignupViewDelegate = MockSignupViewDelegate()
        
        // Act
        sut = SignupPresenter(formModelValidator: mockSignupModelValidator,
                              webservice: mockSignupWebService,
                              delegate: mockSignupViewDelegate)
    }
    
    override func tearDown() {
        signupFormModel = nil
        mockSignupModelValidator = nil
        mockSignupWebService = nil
        sut = nil
    }
    
    func testSignupPresenter_WhenInfomationProvided_WillValidateEachProperty() {
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "last name was not validated")
        XCTAssertTrue(mockSignupModelValidator.isEmailValidated, "email was not validated")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValid, "password was not validated")
        XCTAssertTrue(mockSignupModelValidator.isRepeatPasswordValid, "repaet password was not matched")
    }
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        //Acr
        sut.processUserSignup(formModel: signupFormModel)
        
        // Asset
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "The signup() method was not called in the SignupWebService class")
    }
    
    func testSignupPresenter_WhenSignupOperationSucessful_CallsSuccessOnViewDelegate() {
        
        // Arrange
        let myExpectation = expectation(description: "Expected the successfullSingup() mehtod to be called")
        mockSignupViewDelegate.expectation = myExpectation
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 1, "The SuccessfulSingupCounter is only one")
    }
    
    func testSignupPresenter_WhenSignupOperationFail_CannotCallViewDelegate() {
        
        // Arrange
        let myExpectation = expectation(description: "Expected the Fail to excute successfulSignup() method")
        mockSignupViewDelegate.expectation = myExpectation
        mockSignupWebService.shouldReturnError = true
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        //Asset
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 0)
        XCTAssertEqual(mockSignupViewDelegate.errorHandlercounter, 1)
        XCTAssertNotNil(mockSignupViewDelegate.signupError)
        
    }
}
