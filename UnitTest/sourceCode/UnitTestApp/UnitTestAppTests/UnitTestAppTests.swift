//
//  UnitTestAppTests.swift
//  UnitTestAppTests
//
//  Created by 김광수 on 2020/11/28.
//

import XCTest
@testable import UnitTestApp

class UnitTestAppTests: XCTestCase {
    
    override func setUp() {
        print("setup")
    }
    
    override func tearDown() {
        print("tearDown")
    }
    
    func testViewController_AlwaysRetturnTrue_isTrue() throws {
        
        let value = ViewController().alwaysReturnTure()
        
        XCTAssertTrue(!value)
        
    }

}

