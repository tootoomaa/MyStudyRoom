//
//  SettingsViewModelTests.swift
//  GoodWeatherTests
//
//  Created by 김광수 on 2020/11/23.
//

import XCTest
@testable import GoodWeather

class SettingsViewModelTests: XCTestCase {
  
  private var settingsVM: SettingsViewModel!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    settingsVM = SettingsViewModel()
  }
  
  func test_should_return_correct_display_name_for_fahrenheit() {
    
    XCTAssertEqual(self.settingsVM.selectedUnit.displayName, "Fahrenheit")
    
  }
  
  func test_shoud_make_sure_that_default_selected_unit_is_fahrenheit() {
    // selectedUnit 의 기본값은 .fahrenheit
    XCTAssertEqual(settingsVM.selectedUnit, .fahrenheit)
  }
  
  func test_should_be_able_to_save_user_unit_selection() {
    
    self.settingsVM.selectedUnit = .celsius
    let userDefault = UserDefaults.standard
    XCTAssertNotNil(userDefault.value(forKey: "unit"))
    
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    // 위 테스트로들부터 다양한 Propertie들이 생성되었다. 이것들을 정리하기 위한 코드
    let userDefaults = UserDefaults.standard
    userDefaults.removeObject(forKey: "unit")
    
  }
}
