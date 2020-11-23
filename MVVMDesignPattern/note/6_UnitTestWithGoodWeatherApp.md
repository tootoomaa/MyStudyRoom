# Unit Test With GoodWeather App

### 중요 사항

- Unit 테스트를 작성할때 ViewModel의 **핵심 비지니스 로직** 이 무엇인지 **파악**해야 한다.

-  Unit Test는 해당 메소드의 동작을 파악하는것, 전체적인 프로그램의 정상을 검증해주지는 않는다.

- 불필요한 테스트 예시

  - WeatherListViewModel에서 VM을 추가하는 코드

    - why? WeatherListViewModel의 핵심 기능은 사용자의 옵션(화씨, 섭시)에 따라서 온도를 변경하여 보여주는 로직이 가장 중요

  - ```swift
      func addWeatherViewModel(vm: WeatherViewModel) {
        self.weatherViewModels.append(vm)
      }
    ```

### 테스트 코드

#### SettingsViewModel 테스트

- 화씨 -> 썹시를 변경하는 기능
- UserDefault를 통해 사용자가 지정한 옵션이 잘 저장되는지 여부

```swift
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
```



#### WeatherListViewModel  테스트

- 사용자의 옵션(화씨, 섭시)에 따라서 온도를 변경하여 보여주는 로직 테스트
- toCelsius, toFeherenheit 가 중요한 비지니스 로직

```swift
import XCTest
@testable import GoodWeather

class WeatherListViewModelTests: XCTestCase {
  
  private var weatherListVM: WeatherListViewModel!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.weatherListVM = WeatherListViewModel()
    // 테스트를 위한 데이터 추가
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
      // 결과가 22.2222222..... 이므로 round 처리를 통한 비교 (소수점 이하 반올림)
      XCTAssertEqual(round(vm.currentTemperature.temperature.value), round(celsuisTemperature[index]))
      
    }
    
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
}
```

