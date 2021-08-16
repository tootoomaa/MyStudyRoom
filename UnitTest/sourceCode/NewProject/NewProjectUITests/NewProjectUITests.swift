//
//  NewProjectUITests.swift
//  NewProjectUITests
//
//  Created by 김광수 on 2021/08/01.
//

import XCTest

class NewProjectUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func test_caseWithAuto() {
        
        input("AAA")
        
        app.tables.buttons["AAA"].tap()
        
        let titleLabel = app.staticTexts["AAA"]
        XCTAssertTrue(titleLabel.exists, "When user tap String, Present detail view with title.")
        
        let aaaCell = app.tables.children(matching: .button)
        let aaa = aaaCell.containing(.staticText, identifier: "AAA").firstMatch
        
        XCTAssertTrue(aaa.exists)
    }
    
    func test_InputMultiValue() {
        app.launch()
        
        let list = app.tables["String List"]
        XCTAssertEqual(list.cells.count, 0, "When main View present first, list is empty")
        
        input("Hello")
        XCTAssertEqual(list.cells.count, 1, "When main View present first, list is empty")
        
        input("Nice")
        XCTAssertEqual(list.cells.count, 2, "When main View present first, list is empty")
        
        app.tables.buttons["Nice"].tap()
        
        let niceTitleLabel = app.staticTexts["Nice"]
        XCTAssertTrue(niceTitleLabel.waitForExistence(timeout: 1), "Title Label Show")
        
        app.navigationBars.buttons["String Box"].tap()
        
        XCTAssertFalse(niceTitleLabel.waitForExistence(timeout: 1), "AddStringView disappear")
        XCTAssertTrue(app.navigationBars.buttons["+"].waitForExistence(timeout: 1), "MainView Appear")
        
        
        app.navigationBars["String Box"].buttons["Edit"].tap()
        
        list.cells["Nice"].buttons["Delete "].tap()         // 왼쪽 빨간 동그라미
        list.cells["Nice"].buttons["Delete"].tap()          // 오른쪽 빨간 Delete box
        XCTAssertEqual(list.cells.count, 1, "When main View present first, list is empty")
        
        input("NewValue")
        XCTAssertEqual(list.cells.count, 2, "When main View present first, list is empty")
        
        let helloCellReorderBT = list.cells["Hello"].buttons["Reorder"]
        helloCellReorderBT.swipeDown(velocity: 30)
        
        XCTAssertEqual(list.cells.firstMatch.label, "NewValue")
        
        sleep(10)
    }
    
    private func input(_ text: String) {
        let plusButton = app.navigationBars.buttons["+"]            // + 버튼 찾기
        XCTAssertTrue(plusButton.isEnabled)                         // 버튼 활성화 여부
        app.navigationBars["String Box"].buttons["+"].tap()         // 버튼 탭
        

        let addStringViewText = app.staticTexts["Add String View"]  // String Label 찾기
        XCTAssertTrue(addStringViewText.exists)                     //  택스트 존재 확인
        
        
        let textField = app.textFields["새로운 문자열 추가"]             // 텍스트 필드 찾기
        XCTAssertTrue(textField.exists)                             // 텍스트 필드 존재 확인

        let saveButton = app.buttons["SaveBT"]                      // SaveButton 존제 확인
        XCTAssertFalse(saveButton.isEnabled, "When view pop up, SaveBT is disable") // 활성 상태 확인
        
        textField.tap()
//        app.keys["t"].tap()
//        app.keys["e"].tap()
//        app.keys["s"].tap()
//        app.keys["t"].tap()
        
        textField.typeText(text)
        XCTAssertEqual(text, textField.value as! String, "When user input String, Strings are same")
        XCTAssertTrue(saveButton.isEnabled, "When user input text, save button is enable")
        
        saveButton.tap()
        
        XCTAssertFalse(saveButton.waitForExistence(timeout: 0.5))
        
        sleep(1)
    }

    
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
