//
//  Tca_TutorialTests.swift
//  Tca_TutorialTests
//
//  Created by 김광수 on 2021/12/29.
//

import XCTest
import ComposableArchitecture
@testable import Tca_Tutorial

class Tca_TutorialTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAppStoreAppAction() {
        
        let scheduler = DispatchQueue.test
        
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                mainQueue: scheduler.eraseToAnyScheduler(),
                numberFact: { number in
                    Effect(value: "\(number) is a good number Brent")
                }
            )
        )
        
        store.send(.incrementButtonTapped) { $0.count = 1 }
        store.send(.decrementButtonTapped) { $0.count = 0 }
        store.send(.incrementButtonTapped) { $0.count = 1 }
        store.send(.incrementButtonTapped) { $0.count = 2 }
        store.send(.incrementButtonTapped) { $0.count = 3 }
        store.send(.numberFactButtonTapped)
        scheduler.advance()
        store.receive(.numberFactResponse(.success("3 is a good number Brent"))) {
            $0.numberFactAlert = "3 is a good number Brent"
        }
        store.send(.factAlertDismissed) {
            $0.numberFactAlert = nil
        }
        
    }
    
}
