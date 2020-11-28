//
//  UnitTestAppTests.swift
//  UnitTestAppTests
//
//  Created by 김광수 on 2020/11/28.
//

import XCTest
@testable import UnitTestApp

class UnitTestAppTests: XCTestCase {
    
    static var classInstanceCounter = 0
    
    override class func setUp() {
        super.setUp()
    }
    
    override func setUpWithError() throws {
        print("=========SetUp With Error============")
        UnitTestAppTests.classInstanceCounter += 1
    }
    
    func testExample1() throws {
        print("Accessing class level infomation. Running From Instance # \(UnitTestAppTests.classInstanceCounter)")
    }
    
    func testExample2() throws {
        print("Accessing class level infomation. Running From Instance # \(UnitTestAppTests.classInstanceCounter)")
    }
    
    override func tearDownWithError() throws {
        print("=========tear Down Error============")
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}
