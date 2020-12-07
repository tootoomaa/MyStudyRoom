//
//  XCTAssertNoThrowTutorialTests.swift
//  XCTAssertNoThrowTutorialTests
//
//  Created by 김광수 on 2020/12/07.
//

import XCTest
@testable import XCTAssertNoThrowTutorial

class XCTAssertNoThrowTutorialTests: XCTestCase {
    
    var sut: SignupFormModelValidator!
    
    override func setUpWithError() throws {
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testFirstNameValidation_WhenInvalidCharactersProvieded_ThrowsAnError() {
        // Act
//        XCTAssertThrowsError(try sut.isFirstNameValid("aaa("),
//                             "The firstName contraint invalied Characters when initialized") { error in
//            // Assert
//            XCTAssertEqual(error as? SignupError, SignupError.illigalCharactersFound)
//        }
        
        do {
            
            let _ = try sut.isFirstNameValid("kkkk#")
            XCTFail("The firstName contraint invalied Characters when initialized")
            
        } catch SignupError.illigalCharactersFound {
            
            return
            
        } catch {
            
            XCTFail("The isFirstNameValid() was supposed to throw the SignupError when illigal charactor used. A diffrent Error was Thrown.")
            
        }
    }
    
    func testFirstNameValidation_WhenValiCharactersProvieded_ThrowsNoErrors() {
        
        // Assert
//        XCTAssertNoThrow(try sut.isFirstNameValid("aaaa"), "The isFirstNameValid Should not have thrown an error when there are no illigal characters provieded")
        
        do {
            let _ = try sut.isFirstNameValid("kkkkk")
        } catch {
            XCTFail("The isFirstNameValid() was not supposed to throw an Error when a valid First name Provieded")
        }
        
    }
}
