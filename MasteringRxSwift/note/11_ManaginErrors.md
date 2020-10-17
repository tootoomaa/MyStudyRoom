# Managing Error



### 에러의 종류 

1. No internet
2. Invalid Input
3. API Error or HTTP Error

### Catch

![ErrorManaging_Catch](../image/ErrorManaging_Catch.png)

- 예시
  - `catchErrorJustReturn`

### Retry

![ErrorManaging_Retry](../image/ErrorManaging_Retry.png)

- 시간 기반 재시도

### 소스코드

- ViewController

  - ```swift
        let search = URLRequest.load(resource: resource)
          .observeOn(MainScheduler.instance)
          .retry(3)		// 3번까지 재실행 가능
          .catchError { error -> Observable<Observable<WeatherResult>.E> in
            print("Error", error.localizedDescription)
            return Observable.just(WeatherResult.empty)
          }.asDriver(onErrorJustReturn: WeatherResult.empty)
    ```

- URLRequest Extension

  - ```swift
    extension URLRequest {
      
      static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        
        return Observable.just(resource.url)
          .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.response(request: request)
          }.map { response, data -> T in
            // 에러 처리 추가
            if 200..<300 ~= response.statusCode {
              return try JSONDecoder().decode(T.self, from: data)
            } else {
              throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
            }
          }.asObservable()
      }
    }
    ```

