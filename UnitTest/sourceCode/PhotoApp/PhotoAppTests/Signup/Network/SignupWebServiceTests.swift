//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by 김광수 on 2020/11/30.
//

import XCTest
@testable import PhotoApp

class SignupWebServiceTests: XCTestCase {


    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    // sut : System under test
    func testSignupWebServiceTests_WhenGivenSuccessfullResponse_ReturnSucess() {
        // Arrange
        let sut = SignupWebService(urlString: "http://appsdeveloperblog.com:8080/signup-mock-service/users")
        
        let signupFormRequestModel = SignupFormRequestModel(firstName: "Sergey", lastName: "Kargopolov",
                                                          email: "test@test.com", password: "12345678")
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
                
            // Assert
            // "{\"Status\":\"ok\"}"
            XCTAssertEqual(signupResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
}
