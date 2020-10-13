

# HelloRxSwift

## RxSwift 기본 - Observable 생성

- observable 자체로는 아무일도 발생하지 않음
- subscription을 통해서 실제 값이 전달 되며, complete, error, onNext 이벤트를 발생시킨다.

```swift
let obseravble = Observable.just(1)

let observavle2 = Observable.of(1,2,3) 		// Int individual

let observable3 = Observable.of([1,2,3]) 	// [Int] Array

let observable4 = Observable.from([1,2,3,4,5]) 	// individual Int in Array
```

### from

- Array의 각각의 값을 Next를 통해서 전달 해줌 

- 소스코드 예제

  - ```swift
    let observable4 = Observable.from([1,2,3,4,5]) // indivisual Int in Array
    
    observable4.subscribe { event in
      print(event)
    }
    /* 출력 결과 - next와 함께 [Int]의 각각의 값을 리턴해줌
    next(1)
    next(2)
    next(3)
    next(4)
    next(5)
    completed
    */
    
    observable4.subscribe { event in
      if let element = event.element {
        print(element)
      }
    }
    /* 출력 결과 - 실제 배열의 Int 값만 리턴 해줌
    1
    2
    3
    4
    5
    */
    
    print("====observable4 with OnNext====")
    observable4.subscribe(onNext: { element in
      print(element)
    })
    
    /*
    ====observable4 with OnNext====
    1
    2
    3
    4
    5
    */
    ```

### of 

- 입력된 값 자체를 넘겨준다

- ```swift
  let observable3 = Observable.of([1,2,3]) // [Int] Array
  
  print("\n====observable3====")
  observable3.subscribe { event in
    print(event)
  }
  
  observable3.subscribe { event in
    if let element = event.element {
      print(element)
    }
  }
  
  /*
  ====observable3====
  next([1, 2, 3])
  completed
  
  [1, 2, 3]
  */
  ```

- 

### dispose

- 메모리 누수 방지를 위해서 Observable사용 시 dispose를 처리해주어야 함

- 기본적인 Dispose 추가 방법

  - ```swift
    let subscription4 = observable4.subscribe(onNext: { element in
      print(element)
    })
      
    subscription4.dispose()
    ```

- disposeBag 사용방법 

  - ```swift
    let disposeBag = DisposeBag() // disposebag 생성
    
    Observable.of("A", "B" , "C")
      .subscribe {
        print($0)
      }.disposed(by: disposeBag) // disposebag 에 추가
    
    /*
    next(A)
    next(B)
    next(C)
    completed
    */
    ```



### 최종 예재

```swift
Observable<String>.create { observer in // observable로 전달할 값의 타입을 저장하여 넘길수 있다.
  observer.onNext("A")
  observer.onCompleted()
  observer.onNext("?")         // never call
  return Disposables.create()  // disposable을 만드는 다른 방법
}.subscribe(onNext: { print($0) }, onError: { print($0) }, onCompleted: { print("Completed") }, onDisposed: {print("Dispose")})
.disposed(by: disposeBag)

/*
A
Completed
Dispose
*/
```

- Observable의 생성 방법
  - <type> 을 정하여 생성가능
- onNext, onError, onCompleted 에 클로져 형태로 이벤트 발생시 처리할 사항을 추가로 기입 가능
- coCompleted() 시점에서 해당 Observalbe은 종료되었음으로  `observer.onNext("?")`는 실행되지 않음



### Reference

-   [RxSwift - Dispose란? (Disposable, DisposeBag) :: 고무망치의 Dev N Life](https://rhammer.tistory.com/286) 