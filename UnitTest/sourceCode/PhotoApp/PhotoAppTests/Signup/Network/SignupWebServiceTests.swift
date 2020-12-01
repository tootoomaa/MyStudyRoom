//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by 김광수 on 2020/11/30.
//

import XCTest
@testable import PhotoApp

class SignupWebServiceTests: XCTestCase {

    var sut: SignupWebService!
    var signupFormRequestModel: SignupFormRequestModel!
    
    override func setUp() {
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.signupRequestURL, urlSession: urlSession)
        
        signupFormRequestModel = SignupFormRequestModel(firstName: "Sergey", lastName: "Kargopolov",
                                                          email: "test@test.com", password: "12345678")
    }
    
    override func tearDown() {
        sut = nil
        signupFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    // sut : System under test
    func testSignupWebServiceTests_WhenGivenSuccessfullResponse_ReturnSucess() {
        
        // Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
                
            // Assert
            guard let signupResponseModel = signupResponseModel else { return }
            XCTAssertEqual(signupResponseModel.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testSignupWebService_WhenReceivedDifferentJSONResponse_ErrorTookPlace() {
        
        // Arrange
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = self.expectation(description: "Signup() method expectation for a reponse that contain a difrrent JSON structure")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
                
            // Assert
            XCTAssertNil(signupResponseModel, "The response model for a request containt unknown JSON reponse, Should have been nil")
            XCTAssertEqual(error, SignupError.invalidResponseModel, "The signup() method did not return expected error")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenEmptyURLStringProvieded_ShoudReturnTrue() {
        
        // Arrage
        sut = SignupWebService(urlString: "")
        
        let expectation = self.expectation(description: "An empty request URL String expectation")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { (signupResponseModel, error) in
        
            // Assert
            XCTAssertEqual(error, SignupError.invalidRequestURLString, "The signup() method did not return an expected error for an invalideURLString Error")
            XCTAssertNil(signupResponseModel, "When an invalidRequestURLString takes place, the reponse model must be nil")
            expectation.fulfill()
            
        }
        
        self.wait(for: [expectation], timeout: 2)
        
    }
    
    func testSignupWebService_WhenURLRequestFails_ReturnErrorMessageDescription() {
        // Arrange
        let expectation = self.expectation(description: "A failed Request Expectation")
        let errorDescription = "A localized description of an error"
        
        MockURLProtocol.error = SignupError.failedRequest(description: errorDescription)
        
        //Act
        sut.signup(withForm: signupFormRequestModel) { (signupReponseModel, error) in
            // Assert
            XCTAssertEqual(error, SignupError.failedRequest(description: errorDescription), "The signup() Method did not return an expecter error for the failed Request")
            XCTAssertEqual(error?.localizedDescription, errorDescription)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
        
    }
}
