//
//  TestingUITextFieldPropertiesTests.swift
//  TestingUITextFieldPropertiesTests
//
//  Created by 김광수 on 2020/12/07.
//

import XCTest
@testable import TestingUITextFieldProperties

class TestingUITextFieldPropertiesTests: XCTestCase {

    var sut: SignupViewController!
    
    override func setUpWithError() throws {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = stroyboard.instantiateViewController(identifier: "SignupViewController")
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSignupViewController_WhenCreated_HasEmailAddressContentTypeSet() throws {
        
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Email Address UITextField is not Connected")
        
        XCTAssertEqual(emailTextField.textContentType, UITextContentType.emailAddress, "Email address UITextField dose not have eamilAddress textContentType")
        
    }
    
    func testEmailTextField_WhenCreated_HasEmailKeyboardTypeSet() throws {
        
        let emailTextFields = try XCTUnwrap(sut.emailTextField, "Email Address UITextField is not Connected")
        
        XCTAssertEqual(emailTextFields.keyboardType, UIKeyboardType.emailAddress, "Email Address UITextField dose not have emailAddress UITextField Type")
    }
    
    func testPasswordTextFiedl_WhenCreated_HasSecurityContentTypeSet() throws {
        
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "Password UITextFiedl is not connected")
        
        XCTAssertTrue(passwordTextField.isSecureTextEntry,"Password UITextField is not Security Text Entry")
        
    }
}
