# SOLID

로버트 마틴이 2000년 초반에 명명한 객체 지향 프로그래밍 및 설계의 다섯 가지 기본 원칙을 마이클 페더스가 두문어 기억술로 소개한 것

## What?

#### 1. 단일 책임 원칙 (SRP : Single Responsibility Principle)

- Principle
  - 한 클래스(함수)는 하나의 책임만 가져야 한다
  - 클래스 코드를 수정할 이유는 하나여야 한다
- Check Point
  - 클래스의 인스턴스 변수가 너무 많다.
  - 속성과 상관없는 매서드가 많다
  - 클래스나 매서드를 설명하기 위해서 'and, if, or'를 많이 사용한다.

**Before**

Handler Class에 3가지 기능에 대한 책임이 있다. 각각의 기능에 변경 사항이 있을 경우 `handler 클래스` 자체를 수정해야 한다.

```swift
class Handler {
  func handle() {
    let data = requestDataToAPI()
    let array = parse(data: data)
    saveToDB(array: array)
  }
    
  private func requestDataToAPI() -> Data {  // 1. API 기능 
  // send API request and wait the response
  }
    
  private func parse(data: Data) -> [String] {  // 2. date parse 기능
  // parse the data and create the array
  }
    
  private func saveToDB(array: [String]) {  // 3. DB 저장 기능
  // save the array in a database (CoreData/Realm/...)
  }
}
```

**After**

`Handler 클래스` 내 기능들을 각각의 class 분리

```swift
class Handler {
 
    let apiHandler: APIHandler
    let parseHandler: ParseHandler
    let dbHandler: DBHandler
 
    init(apiHandler: APIHandler, parseHandler: ParseHandler, dbHandler: DBHandler) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
        self.dbHandler = dbHandler
    }
 
    func handle() {
        let data = apiHandler.requestDataToAPI()
        let array = parseHandler.parse(data: data)
        dbHandler.saveToDB(array: array)
    }
}
// 1. API 기능 
class APIHandler {
 
    func requestDataToAPI() -> Data {
        // send API request and wait the response
    }
}
// 2. date parse 기능
class ParseHandler {
 
    func parse(data: Data) -> [String] {
        // parse the data and create the array
    }
}
// 3. DB 저장 기능
class DBHandler {
 
    func saveToDB(array: [String]) {
        // save the array in a database (CoreData/Realm/...)
    }
}
```



#### 2. 개방-폐쇄 원칙 (OCP : Open/closed principle)

- Principle
  - 확장에는 열려있으나 변경에는 닫혀 있어야 한다.
  - 모듈이 주변 환경에 지나치게 의존해서는 안 된다.
- Check Point
  - 객체가 변경될 때는 해당 객체만 바꿔도 동작이 잘 되면 OCP를 잘 지킨것이고, 바꿔야 할 것이 많으면 OCP를 위반 한 것
  - 기능 케이스를 추가할 때 기존 코드를 변경하지 않고 확장해야 한다.
  - 자신의 속성보다는 외부의 속성에 의존하고 있지 않은가?
  - 인터페이스보다는 구현한 타입에 의존하고 있지는 않은가?

**Before**

example1

- UAS 케이스를 추가해야 할 때, `enum` 과 `printNameOfCountry` 함수를 둘다 수정해야 함

```swift
enum Country {
  case korea
  case japan
  case china
}

class Flag {
  let country: Country
  
  init(country: Country) {
    self.country = country
  }
}

func printNameOfCountry(flag: Flag) {
  switch flag.country {
    case .china:
      print("중국")
    case .korea:
      print("한국")
    case .japan:
      print("일본")
  }
}
```

example2

- UAS 케이스를 추가해야 할 때, `enum` 과 `내부 name 변수의 Swith` 둘다 수정해야 함

```swift
enum Country {
  case korea
  case japan
  case china
    
  var name: String {
    switch self {
      case .china:
        return "중국"
      case .korea:
        return "한국"
      case .japan:
        return "일본"
    }
  }
}

class Flag {
  let country: Country
    
  init(country: Country) {
    self.country = country
  }
}

func printNameOfCountry(flag: Flag) {
  print(flag.country.name)
}
```

**After**

'USA를 추가할 때 `Country` 를 상속 받은 Struct만 추가하면 다른 코드 부분은 수정할 필요가 없다.

```swift
protocol Country {
  var name: String { get }
}

struct Korea: Country {
  let name: String = "한국"
}

struct Japan: Country {
  let name: String = "일본"
}

struct China: Country {
  let name: String = "중국"
}

class Flag {
  let country: Country
  
  init(country: Country) {
    self.country = country
  }
}

func printNameOfCountry(flag: Flag) {
  print(flag.country.name)
}
```



#### 3. 리스코프 치환 원칙 (LSP : Liskov substitution principle)

- Principle
  - 서브타입은 ( 상속받은 ) 기본 타입으로 대체 가능해야 한다.
  - 자식 클래스는 부모 클래스 동작(의미)를 바꾸지 않는다.
- Check Point
  - 상속을 사용했을 때 서브클래스는 자신의 슈퍼 클래스 대신 사용되도 같은 동작을 해야한다.
  - 자식 클래스의 너무 많은 override가 구현 되어있다. (별도 Class로 분리 !?)
  - 수직적 확장, 수평적 확장 중 어느 것이 필요한 상황인지 생각해본다.

**Before**

- 정사각형에서 직사각형의 `너비` 를 `override` 하여 상위 클래스를 통해 넓이를 구할 경우 정사각형은 `넓이`가 정상적으로 나오지 않게됨
- 즉, 정사각형(서브클래스)의 override한 너비 타입 때문에, 직사각형(슈퍼클래스)의 기본 너비 타입으로 대체가 불가능! LSP 원칙 위반.

```swift
class 직사각형 {
  var 너비: Float = 0
  var 높이: Float = 0
  var 넓이: Float {
    return 너비 * 높이
  }
}

class 정사각형: 직사각형 {
  override var 너비: Float {  // <-- 문제가 되는 override 부분
    didSet {
      높이 = 너비
    }
  }
}

func printArea(of 직사각형: 직사각형) {
  직사각형.높이 = 5
  직사각형.너비 = 2
  print(직사각형.넓이)
}

let rectangle = 직사각형()
printArea(of: rectangle) //10
let square = 정사각형()
printArea(of: square) //4
```

**After**

```swift
protocol 사각형 {
  var 넓이: Float { get }
}

class 직사각형: 사각형 {
  private let 너비: Float
  private let 높이: Float
  
  init(너비: Float, 높이: Float) {
    self.너비 = 너비
    self.높이 = 높이
  }
  
  var 넓이: Float {
    return 너비 * 높이
  }
}

class 정사각형: 사각형 {
  private let 변의길이: Float
  
  init(변의길이: Float) {
    self.변의길이 = 변의길이
  }
  
  var 넓이: Float {
    return 변의길이 * 변의길이
  }
}
```



#### 4. 인터페이스 분리 원칙 (ISP : Interface segregation principle)

- Principle
  - 클래스 내에서 사용하지 않는 인터페이스는 구현하지 말아야 한다.
  - 클라이언트 객체는 사용하지 않는 메소드에 의존하면 안된다.
  - 
- Check Point
  - 프로토콜을 체택하고 어쩔 수 없이 의미없는 구현을 하고 있진 않은지
  - 해당 프로토콜이 하나의 역할을 하는가?

**Before**

```swift
protocol GestureProtocol {
  func didTap()
  func didLongTap()
  func didDoubleTap()
}

class GestureButton: GestureProtocol {
  func didTap() {}
  func didLongTap() {}
  func didDoubleTap() {}
}

class DoubleTapButton: GestureProtocol {
  func didDoubleTap() {}
  
  // 사용하지 않는 메소드들이 있다.
  func didTap() {}
  func didLongTap() {}
}
```

**After**

- Protocol을 분리하여 사용되지 않는 메소드가 없도록 구현

```swift
protocol TapGestureProtocol {
  func didTap()
}

protocol LongTapGestureProtocol {
  func didLongTap()
}

protocol DoubleTapGestureProtocol {
  func didDoubleTap()
}

class GestureButton: TapGestureProtocol, LongTapGestureProtocol, DoubleTapGestureProtocol {
  func didTap() {}
  func didLongTap() {}
  func didDoubleTap() {}
}

class DoubleTapButton: GestureProtocol {
  func didDoubleTap() {}
}

class LongAndTapButton: LongTapGestureProtocol, TapGestureProtocol {
  func didTap() {}
  func didLongTap() {}
}

func doSomething(button: DoubleTapGestureProtocol & LongTapGestureProtocol) {
  button.didDoubleTap()
  button.didLongTap()
}
```



#### 5. 의존관계 역전 원칙 (DIP : Dependency inversion principle)

- Principle
  - 상위레벨 모듈은 하위레벨 모듈에 의존하면 안된다.
  - 두 모듈은 추상화된 인터페이스(프로토콜)에 의존해야 한다.
  - 추상화된 것은 구체적인 것에 의존하면 안되고, 구체적인 것이 추상화된 것에 의존해야 한다.
- Check Point
  - 내부적으로 생성하는 하위 모듈이 존재하는가? ( 주입 X )
  - 상위 레벨 모듈이 재사용 가능한가?
  - 하위 레벨 모듈의 구체적인 타입이 존재하는가?

**before**

```swift
class 맥북13인치 {
  func 전원켜기() {}
}

class 개발자 {
  let 노트북: 맥북13인치 = 맥북13인치()
  
  func 개발시작() {
    노트북.전원켜기()
  }
}
```

의존성 주입 ( DI )

- 개발자 클래스가 `맥북13인치` 에 의존되도록 초기화 시 노트북을 `UI 의존성 주입` 받았다.

```swift
class 맥북13인치 {
  func 전원켜기() {}
}

class 개발자 {
  let 노트북: 맥북13인치
  
  init(노트북: 맥북13인치) {  // < -- 의존성 주입
    self.노트북 = 노트북
  }
  
  func 개발시작() {
    노트북.전원켜기()
  }
}
```

- But 구체화된 맥북 13인치보다 추상화된 `장비`으로 변경하는 것이 변화에 더 유연하다

**After**

- 개발자는 `추상화된 장비`에 의존하도록 변경
- 추상화된 장비를 통해서 장비의 변화에 유연하게 대응 가능

```swift
protocol 장비 {  // < - 추상화된 노트북
  func 전원켜기()
}

class 개발자 {
  let 노트북: 장비
  
  init(맥북: 장비) {  // <-- 추상화된 노트북에 의존성을 가짐
    self.장비 = 맥북
  }
  
  func 개발시작() {
    장비.전원켜기()
  }
}

// 장비 Protocol
class 맥북13인치: 장비 {
  func 전원켜기() {}
}

class 맥북15인치: 장비 {
  func 전원켜기() {}
}

class 레노버: 장비 {
  func 전원켜기() {}
}
```

## Why?

> 결합도👇🏻 응집도👆🏻

- 경직성 : 하나를 바꿀때 다른것들도 바꿔야해서 시스템을 변경하기 어렵다
- 부서지기 쉬움: 한 부분이 변경되었을 때 다른 한 부분이 영향을 받아서 새로운 오류가 발생한다.
- 부동성 : 다른 시스템이 재사용하기 힘들다
- 불필요한 복잡성 : 과도한 설계
- 불필요한 반복
- 불투명성 : 의도를 파악하기 어려운 혼란스러운 표현



### Reference

[SOLID (객체 지향 설계)](https://ko.wikipedia.org/wiki/SOLID_(객체_지향_설계))

[let us: Go! 2019 봄 - 세션 6](https://www.youtube.com/watch?v=QXVO2NcarkQ&feature=emb_logo)

[오늘의 Swift 상식 (객체와 SOLID 원칙)](https://medium.com/@jgj455/오늘의-swift-상식-객체와-solid-원칙-270415c64b64)