//
//  MainViewModelTests.swift
//  UnitTestExampleTests
//
//  Created by 김광수 on 2021/05/08.
//

import XCTest

@testable import UnitTestExample
class MainViewModelTests: XCTestCase {

    var vm: MainViewModel!
    
    override func setUpWithError() throws {
        vm = MainViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
    }
    
    func testMainViewModel_WhenNameAndPasswordNotProvided_ShouldReturnFalse() {
        // act
        vm.name = ""
        vm.password = ""
        
        // assert
        XCTAssertEqual(false, vm.isLoginBtEnable)
    }
    
    func testMainViewModel_WhenNameAndPasswordProvided_ShouldReturnTrue() {
        // act
        vm.name = "kwangsoo"
        vm.password = "password123"
        
        // assert
        XCTAssertEqual(true, vm.isLoginBtEnable)
    }

}
