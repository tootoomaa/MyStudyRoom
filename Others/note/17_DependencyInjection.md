# Dependency injection ( DI )

### What is dependency injection

> 현재 객체가 다른 객체와 상호작용(참조) 하고 있다면 현재 객체는 다른 객체에 의존성을 가진다

### Advantages of dependency injection in Swift

- 커플링 감소
- 코드 재사용성 증가
- 테스터블 코드
- 유지보수 용이성

### Kind of dependecy 

1. Contructor Injection

   - 생성자를 통한 전달

   - ```swift
     let user = User(name: "kks", age: 20)
     ```

2. Method(Setter) Injection

   - ```swift
     let user = User()
     user.setter(name: "kks", age: 20)
     ```

3. Field Injection

   - ```swift
     let user = User()
     user.name = "kks"
     user.age = 20
     ```

### Dependency injection example

- Protocol 을 이용한 DI 주입

  - 문제 사항

    - ```swift
      protocol NetworkManagerProtocol {
          func login(username: String, password: String, completion: @escaping (Data, Error) -> Void)
      }
      
      class loginViewModel {
          var networkManager: NetworkManagerProtocol = NetworkManager() // <- Problem
      
          private func loginWith(name: Stirng, password: String) {
              networkManager.login(username: name, password: password, ©ompletion: { (data, error) in
                  guard error != nil else {
                      // Deal with error
                      return
                  }
                  // Authorize login
              })
          }
      }
      ```

    - LoginViewModel안에서 자체적으로 NetworkManager 의 인스턴스를 만들고 있어  LoginViewModel과 NetworkManager사이의 Coupling을 높이고 있다

    - NetowrkManager instance가 내부에서 생성됨으로 LoginViewModel에 대한 독립적인 테스트가 불가능

  - 해결 방법

    - ```swift
      protocol NetworkManagerProtocol {
          func login(username: String, password: String, completion: @escaping (Data, Error) -> Void)
      }
      
      class loginViewModel {
          var networkManager: NetworkManager
      
          init(networkManager: NetworkManagerProtocol) { // DI
              self.networkManager = networkManager
          }
      
          private func loginWith(name: Stirng, password: String) {
              self.networkManager.login(username: name, password: password, ©ompletion: { (data, error) in
              guard error != nil else {
                  // Deal with error
                  return
              }
              // Authorize login
          })
      }
      ```

    - LoginViewModel 생성과 동시에 초기화 부분에 NetworkManager 추가 주입

### Dependency injection testing

 위의 변경된 LoginViewModel 코드를 테스트하기 위해서 아래와 같이 Network Mock을 생성하여 테스트 할 수 있다

- Mock

  - ```swift
    class NetworManagerMock: ProductManagerProtocol {
        func login(username: String, password: String, completion: @escaping (Data, Error) -> Void) {
            completion(data, nil)
        }
    }
    ```

- 에러가 필요한 경우

  - ```swift
    class NetworManagerMock: ProductManagerProtocol {
        func login(username: String, password: String, completion: @escaping (Data, Error) -> Void) {
            completion(nil, error)
        }
    }
    ```

- 테스트 코드

  - ```swift
    class LoginViewModelTests: XCTestCase {
        func testLogiViewModelWithData() {
            let networkManagerMock = NetworManagerMock()
            let loginViewModel = LoginViewModel(networkManager: networkManagerMock)
            let expectation = self.expectation(description: "Networking")
            let loginData: Data
    
            networkManager.loginWith(username: "Marc", password: "1234", ©ompletion: { (data, error) in
                loginData = data
                expectation.fulfill()
            })
    
            waitForExpectations(timeout: 5, handler: nil)
            XCTAssertNotNil(data)
        }
    }
    ```



### Reference

-   [Dependency Injection in Swift. Develop more decoupled and testable… | by Raúl Ferrer | The Startup | Nov, 2020 | Medium](https://medium.com/swlh/dependency-injection-in-swift-964e1caaa8c1)
-   [Design Pattern DI란 (Dependency Injection) - Heee's Development Blog](https://gmlwjd9405.github.io/2018/11/09/dependency-injection.html) 
