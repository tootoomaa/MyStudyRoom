# Good Weather App

## 구현 화면

- 날씨 API를 통해 특정 도시의 날씨의 온도와 습도를 받아오는  App
- RxSwift 및 RxCocoa를 사용하여 구현

![GoodWeatherApp](../image/GoodWeatherApp.gif)

## 소스코드

### 구현 과정

- URLResquest+Extension.swift

  - ```swift
    struct Resource<T> {
      let url: URL
    }
    
    extension URLRequest {
      static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        return Observable.from([resource.url])
          .flatMap { url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
          }.map { data -> T in
            return try JSONDecoder().decode(T.self, from: data)
          }.asObservable()
      }
    }
    ```

- URL+Extension.swift

  - ```swift
    extension URL {
      static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=`key`")!
      }
    }
    ```

- viewController.swift

  - ```swift
      let disposeBag = DisposeBag()
      
      override func viewDidLoad() {
        super.viewDidLoad()
        // 사용자가 입력을 종료하는 이벤트(.editingDidEndOnExit) 발생시 text값을 방출
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
          .asObservable()
          .map { self.cityNameTextField.text }
          .subscribe(onNext: { city in
            
            if let city = city {
              if city.isEmpty {
                self.displayWeather(nil)
              } else {
                self.fetchWeather(by: city)
              }
            }
          }).disposed(by: disposeBag)
      }
    ```

- 날씨 변경 부분

  - ```swift
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        
        let resource = Resource<WeatherResult>(url: url)
        
        // driver를 통한 UI 변경
        let search = URLRequest.load(resource: resource)
          .asDriver(onErrorJustReturn: WeatherResult.empty) 
      		// 에러가 방출되는것을 막기위해서 기본값을 리턴하도록 설정함
        
        search.map { "\($0.main.temp)℉" }
          .drive(self.temperatureLabel.rx.text)
          .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity)💦"}
          .drive(self.humidityLabel.rx.text)
          .disposed(by: disposeBag)
      }
      
      private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
          self.temperatureLabel.text = "\(weather.temp)℉"
          self.humidityLabel.text = "\(weather.humidity)💦"
        } else {
          self.temperatureLabel.text = "👻"
          self.humidityLabel.text = "😱"
        }
      }
    ```



## 기초 이론 

### bindTo

- observable의 binding은 단방향으로 만 가능하다.
- ObserverType을 따름, 값을 주입시킬 수는 있지만, 값을 관찰할 수는 없음

![BindTo_Operator](../image/BindTo_Operator.png)

### Control Property 

- subject와 같이 프로퍼티에 새 값을 주입할 수 있고( ObservavleType) 값의 변화도 관찰할 수 있는 타입 (ObservabeType)

- 소스코드 예시

  - ```swift
    self.cityNameTextField.rx.value.subscribe(onNext: { city in
    	// city를 사용해 처리할 사항
    	}).disposed(by: disposeBag)
    ```


### Control Event

- 특정 이벤트가 발생했을때 처리할 사항을 정의할 수 있다.

- 소스코드 예시

  - ```swift
    // cityNameTextField에서 특정 이벤트가 발생하면 방출되도록 설정한 옵션
    // - .editingDidEndOnExitq 부분에 특정 Property에 이벤트의 종류를 정의해줌
    self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
     // 이벤트가 발생했을때 처리할 사항
     }).disposed(by: disposeBag)
    ```


### Driver

- UI Layer에서 좀 더 직관적으로 사용하도록 제공하는 unit
- Driver는 기본적으로 MainScheduler에서 실행됨

### Reference

-  [[RxSwift Book] Chapter 12: Beginning RxCocoa – 토미의 개발노트 – iOS 개발관련 지식을 공유합니다.](https://jusung.github.io/RxSwift-Section12/) 
