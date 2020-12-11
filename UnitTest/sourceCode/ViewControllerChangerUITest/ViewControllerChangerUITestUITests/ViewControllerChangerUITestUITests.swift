//
//  ViewControllerChangerUITestUITests.swift
//  ViewControllerChangerUITestUITests
//
//  Created by 김광수 on 2020/12/11.
//

import XCTest

class ViewControllerChangerUITestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFirstViewController_WhenButtonTapped_PresentSecondViewController() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Button"].tap()
        
        let viewController = app.otherElements["SecondViewController"].waitForExistence(timeout: 1)
        
        XCTAssertTrue(viewController, "When the Button tapped, SecondViewController should presented")
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
