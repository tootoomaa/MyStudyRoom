//
//  CalculatorAppTests.swift
//  CalculatorAppTests
//
//  Created by 김광수 on 2020/11/22.
//

import XCTest
@testable import CalculatorApp

class CalculatorAppTests: XCTestCase {
  
  private var calculator = Calculator()
  
  override class func setUp() {
    super.setUp()

  }
  
  func test_SubtractTwoNumbers() {
    
    let result = self.calculator.subtract(5,2)
    
    XCTAssertEqual(result, 3)
    
  }

  func test_AddTwoNumbers() {
    
    let result = self.calculator.add(2,3)
    
    XCTAssertEqual(result, 5)
    
  }
  
  override class func tearDown() {
    super.tearDown()
    // Some change thing remove here [after test]
    
  }
}
