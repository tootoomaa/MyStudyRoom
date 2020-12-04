//
//  SignupViewControllerTests.swift
//  PhotoAppTests
//
//  Created by 김광수 on 2020/12/04.
//

import XCTest
@testable import PhotoApp

class SignupViewControllerTests: XCTestCase {

    var stroyboard: UIStoryboard!
    var sut: SignupViewController!
    
    override func setUp() {
        stroyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = stroyboard.instantiateViewController(identifier: "SignupViewController") as? SignupViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        stroyboard = nil
        sut = nil
    }

    func testSignupViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        // IBOutlet이 잘 연결 되어 있는지 확인
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "The firstNameTextField is not connected to an IBOutlet")
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "The lastNameTextField is not connected to an IBOulet")
        let emailTextField = try XCTUnwrap(sut.emailTextField, "The emailTextField is not connected to an IBOutlet")
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "The passwordTextField is not connected to an IBOulet")
        let repeatPasswordTextField = try XCTUnwrap(sut.repeatPasswordTextField, "The RepeatPasswordTextField is not connected to an UIBOutlet")
        
        XCTAssertEqual(firstNameTextField.text, "", "FirstNameTextField was not empty when the view controller inittially loaded")
        XCTAssertEqual(lastNameTextField.text, "", "lastNameTextField was not empty when the view controller inittially loaded")
        XCTAssertEqual(emailTextField.text, "", "emailTextField was not empty when the view controller inittially loaded")
        XCTAssertEqual(passwordTextField.text, "", "passwordTextField was not empty when the view controller inittially loaded")
        XCTAssertEqual(repeatPasswordTextField.text, "", "repeatPasswordTextField was not empty when the view controller inittially loaded")
    }
    
    func testViewController_WhenCreated_HasSignupButtonAndAction() throws {
        // Arrange
        let signupButton: UIButton = try XCTUnwrap(sut.signpButton, "Signup button dose not have a referencing outlet")
        
        // Act
        let signupButtonActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        
        // Assert
        XCTAssertEqual(signupButtonActions.count, 1, "Signup button dose not have any actions assigned to it")
        XCTAssertEqual(signupButtonActions.first, "signupButtonTapped:", "There is no action with a name signupbuttonTapped assigned to singup button")
    }
}
