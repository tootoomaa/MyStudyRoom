//
//  SignupFlowUITests.swift
//  SignupFlowUITests
//
//  Created by 김광수 on 2020/12/09.
//

import XCTest

class SignupFlowUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private var firstName: XCUIElement!
    private var lastName: XCUIElement!
    private var email: XCUIElement!
    private var password: XCUIElement!
    private var repeatPassword: XCUIElement!
    private var signupButton: XCUIElement!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()

        app = XCUIApplication()
        app.launch()
        
        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        email = app.textFields["emailTextField"]
        password = app.secureTextFields["passwordTextField"]
        repeatPassword = app.secureTextFields["repeatPasswordTextField"]
        signupButton = app.buttons["signupButton"]
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        firstName = nil
        lastName = nil
        email = nil
        password = nil
        repeatPassword = nil
        signupButton = nil
        try super.tearDownWithError()
    }

    func testSignupViewcontroller_WhenViewLoaded_RequiredUIElementsAreEnabled() throws {
                        
        XCTAssertTrue(firstName.isEnabled, "First name UITextField is not enabled for user interactions")
        XCTAssertTrue(lastName.isEnabled, "Last name UITextField is not enabled for user interactions")
        XCTAssertTrue(email.isEnabled, "Email name UITextField is not enabled for user interactions")
        XCTAssertTrue(password.isEnabled, "Password name UITextField is not enabled for user interactions")
        XCTAssertTrue(repeatPassword.isEnabled, "Repeat Password name UITextField is not enabled for user interactions")
        XCTAssertTrue(signupButton.isEnabled, "Signup Button is not enabled for user interactions")
        
    }
    
    func testViewController_WhenInvalidFormSubmitted_PresentsErrorAlertDialog() {
        // Arrange
        firstName.tap()
        firstName.typeText("S")
        
        lastName.tap()
        lastName.typeText("b")
        
        email.tap()
        email.typeText("@")
        
        password.tap()
        password.typeText("123456")
        
        repeatPassword.tap()
        repeatPassword.typeText("123")
        
        // Act
        signupButton.tap()
            
//        let emailTextFieldScreenshot = email.screenshot()
//        let emailTextFieldAttachment = XCTAttachment(screenshot: emailTextFieldScreenshot)
//        emailTextFieldAttachment.name = "Screenshot of Email UITextField"
//        emailTextFieldAttachment.lifetime = .keepAlways
//        add(emailTextFieldAttachment)
//        
//        let currentAppWindow = app.screenshot()
//        let currentAppWindowAttachment = XCTAttachment(screenshot: currentAppWindow)
//        currentAppWindowAttachment.name = "Signup page screenshot"
//        currentAppWindowAttachment.lifetime = .keepAlways
//        add(currentAppWindowAttachment)
        
        // Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1),
                      "An Error alert dialog was not Presented when invalid signup form was submitted")
    }
    
    func testViewController_WhenValidFormSubmitted_PresentsErrorAlertDialog() {
        // Arrange
        firstName.tap()
        firstName.typeText("Sergey")
        
        lastName.tap()
        lastName.typeText("Kargopolov")
        
        email.tap()
        email.typeText("test@test.com")
        
        password.tap()
        password.typeText("12345678")
        
        repeatPassword.tap()
        repeatPassword.typeText("12345678")
        
        // Act
        signupButton.tap()
        
        // Assert
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 1),
                      "A Success alert dialog was not Presented when valid signup form was submitted")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
