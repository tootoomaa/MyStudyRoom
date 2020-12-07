//
//  LoadingViewControllerUnitTestTests.swift
//  LoadingViewControllerUnitTestTests
//
//  Created by 김광수 on 2020/12/06.
//

import XCTest
@testable import LoadingViewControllerUnitTest

class LoadingViewControllerUnitTestTests: XCTestCase {

    var sut: ViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "ViewController") as? ViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
