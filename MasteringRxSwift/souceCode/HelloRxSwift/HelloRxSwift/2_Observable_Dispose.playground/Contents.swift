import Cocoa
import RxSwift

let obseravble = Observable.just(1)

let observavle2 = Observable.of(1,2,3) // Int indivisual

let observable3 = Observable.of([1,2,3]) // [Int] Array

let observable4 = Observable.from([1,2,3,4,5]) // indivisual Int in Array

print("\n====observable4====")
observable4.subscribe { event in
  print(event)
}

observable4.subscribe { event in
  if let element = event.element {
    print(element)
  }
}

print("====observable4 with OnNext====")
observable4.subscribe(onNext: { element in
  print(element)
})

print("\n====observable3====")
observable3.subscribe { event in
  print(event)
}

observable3.subscribe { event in
  if let element = event.element {
    print(element)
  }
}

print("\n====Dispose====")

let subscription4 = observable4.subscribe(onNext: { element in
  print(element)
})

subscription4.dispose()

// dispose

let disposeBag = DisposeBag()

Observable.of("A", "B" , "C")
  .subscribe {
    print($0)
  }.disposed(by: disposeBag)


Observable<String>.create { observer in
  observer.onNext("A")
  observer.onCompleted()
  observer.onNext("?")         // never call
  return Disposables.create()  // disposable을 만드는 다른 방법
}.subscribe(onNext: { print($0) }, onError: { print($0) }, onCompleted: { print("Completed") }, onDisposed: {print("Dispose")})
.disposed(by: disposeBag)
