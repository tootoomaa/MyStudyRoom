//
//  LaodingViewControllerWithCode.swift
//  LoadingViewControllerUnitTestTests
//
//  Created by 김광수 on 2020/12/06.
//

import XCTest
@testable import LoadingViewControllerUnitTest

class LaodingViewControllerWithCode: XCTestCase {

    var sut: HomePageViewController!
    
    override func setUpWithError() throws {
        
        sut = HomePageViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
