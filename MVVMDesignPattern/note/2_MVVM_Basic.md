# MVVM Design Pattern

### MVVM 기본 구조

![MVVM_Basic](../image/MVVM_Basic.png)

1. Model
   - 기본적인 데이터 모델와 어플리케이션이 소유하고 있는 entities
   - Properties와 관련된 struct 또는 class
   - 단순히 데이터를 가지고 있거나, 서버나, API를 통해 가져온 데이터를 특정 구조로 변환
2. View or ViewController
   - 앱의 화면에 표현되는 UI 구성요소 포함
   - Data Rendering, navigaion과 같은 UI 로직만 포함
   - ViewModel을 소유한다
3. ViewModel
   - UI 이벤트를 받아서 비지니스 로직을 실행하고, UI에 표현될 데이터를 돌려줌
   - This is the component that is responsible for handling the business logic driving the view. But it internally does not modify the UI, neither it has any reference to the view.
   - Data Model을 소유한다

### MVVM 이점

1. Segregated Code
   - View - ViewModel - View 의 구조로 코드가 분리됨
   - 위 구조는 모듈화된 코드 구조를 제공함
2. Avoid Bulky Controller
   - Contoller에 비지니스 로직이 많아져 거대해지는 것을 방지
3. Test Driven Development
   - ViewModel에 대한 Unit 테스트를 통해서 TDD가 가능