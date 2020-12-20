//
//  UserDefaultsServiceTests.swift
//  MyRxTodoAppTests
//
//  Created by 김광수 on 2020/12/19.
//

import XCTest
@testable import MyRxTodoApp

class UserDefaultsServiceTests: XCTestCase {
  
  var userDefaultsService: UserDefaultsService!
  
  override func setUpWithError() throws {
    
    userDefaultsService = UserDefaultsService()
    
  }
  
  override func tearDownWithError() throws {
    userDefaultsService.set(value: [])
    userDefaultsService = nil
  }
  
  func testUserDefaultsService_WhenInitCreated_ShouldValueReturnEmptyArray() {
    
    let tasks = userDefaultsService.value()
    
    XCTAssertEqual([], tasks,"UserDefaults의 최초값이 없을 경우 런타임 오류 방지를 위해서 []를 반환 합니다")
    
  }
  
  func testUserDefaultsService_InputStringArray_ShouldReturnStringArray() {
    
    let tasks = ["Buy Apple", "Buy Banana"]
    userDefaultsService.set(value: tasks)
    
    XCTAssertEqual(userDefaultsService.value(), tasks, "UserDefailts의 set(value:)을 통해서 들어간 변수는 value() 변수와 동일해야 합니다")
    
  }
  
}
