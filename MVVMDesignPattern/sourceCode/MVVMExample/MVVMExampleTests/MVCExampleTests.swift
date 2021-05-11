//
//  MVVMExampleTests.swift
//  MVVMExampleTests
//
//  Created by 김광수 on 2021/05/11.
//

import XCTest

@testable import MVVMExample
class MVCExampleTests: XCTestCase {
    
    var sut: ContentView!

    override func setUpWithError() throws {
        sut = ContentView()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    /*
     Login button 은 true 일때 disable
     */
    func testContentView_WhenUserEamilIsEmpty_LoginButtonStateShouldReturnTrue() {
        
        sut.email = ""
        sut.password = "123123"
        
        XCTAssertTrue(sut.email.isEmpty || sut.password.isEmpty, "로그인 버튼 비활성화")
    }
    
    func testContentView_WhenUserPasswordIsEmpty_LoginButtonStateShouldReturnTrue() {
        
        sut.email = "123123"
        sut.password = ""
        
        XCTAssertTrue(sut.email.isEmpty || sut.password.isEmpty, "로그인 버튼 비활성화")
    }
    
    func testContentView_WhenPasswordAndEmailisValid_LoginButtonStateShouldReturnFalse() {
        sut.email = "123123"
        sut.password = "123123"
        
        XCTAssertTrue(sut.email.isEmpty || sut.password.isEmpty, "로그인 버튼 활성화")
    }
}
