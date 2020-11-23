//
//  WeatherListViewModelTests.swift
//  GoodWeatherTests
//
//  Created by 김광수 on 2020/11/23.
//

import XCTest
@testable import GoodWeather

class WeatherListViewModelTests: XCTestCase {
  
  private var weatherListVM: WeatherListViewModel!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.weatherListVM = WeatherListViewModel()
    
    let weatherVM = WeatherViewModel("Huston", TemperatureViewModel(32, 0, 0))
    let weatherVM2 = WeatherViewModel("Seoul", TemperatureViewModel(72, 0, 0))
    self.weatherListVM.addWeatherViewModel(vm: weatherVM)
    self.weatherListVM.addWeatherViewModel(vm: weatherVM2)
    
  }
  
  // toCelsius, toFeherenheit 가 중요한 비지니스 로직
  func test_should_be_able_to_convert_to_celsius_successfully() {
    
    let celsuisTemperature = [0, 22.2222]
    
    self.weatherListVM.updateUnit(to: .celsius)
    
    for (index, vm) in self.weatherListVM.weatherViewModels.enumerated() {
      
      XCTAssertEqual(round(vm.currentTemperature.temperature.value), round(celsuisTemperature[index]))
      
    }
    
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
}
