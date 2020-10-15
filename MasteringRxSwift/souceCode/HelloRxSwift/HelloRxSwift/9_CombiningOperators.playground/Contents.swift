import Cocoa
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

print("\n==== [ Start With ] ====\n")
let numbers = Observable.of(2,3,4)

let observable = numbers.startWith(1)
observable.subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)

print("\n==== [ concat ] ====\n")

let firstSeq = Observable.of(1,2,3)
let secondSeq = Observable.of(4,5,6)

let concatedObservable = Observable.concat([firstSeq, secondSeq])
concatedObservable
  .subscribe(onNext:{
    print($0)
  }).disposed(by: disposeBag)

print("\n==== [ Merge ] ====\n")

//let left = PublishSubject<Int>()
//let right = PublishSubject<Int>()

//let source = Observable.of(left.asObserver(), right.asObserver())
//
//let mergeObservable = source.merge()
//mergeObservable.subscribe(onNext: {
//  print($0)
//}).disposed(by: disposeBag)
//
//left.onNext(5)
//left.onNext(2)
//right.onNext(2)
//right.onNext(1)
//left.onNext(99)

print("\n==== [ combind Lastest ] ====\n")

let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let combineLatestObservable = Observable.combineLatest(left, right, resultSelector: {
  lastLeft, lastRight in
  "\(lastLeft) \(lastRight)"
})

let dispoable = combineLatestObservable.subscribe(onNext: { value in
  print(value)
})

 left.onNext(46)
right.onNext(1)
left.onNext(30)
right.onNext(99)
right.onNext(2)

print("\n==== [ withLatestFrom ] ====\n")


let button = PublishSubject<Void>() // 버튼은 리턴하는 타입이 없다
let textField = PublishSubject<String>()

let observableButton = button.withLatestFrom(textField)

let disposable = observableButton.subscribe(onNext: {
  print($0)
})

textField.onNext("Sw")
textField.onNext("Swif")
textField.onNext("Swift")

button.onNext(())
button.onNext(())


print("\n==== [ reduce ] ====\n")

let source = Observable.of(1,2,3)

source.reduce(0, accumulator: +)
  .subscribe(onNext:{
    print($0)
  }).disposed(by: disposeBag)


source.reduce(0, accumulator: {
  summary, newValue in
  return summary + newValue
}).subscribe(onNext: {
  print($0)
}).disposed(by: disposeBag)

print("\n==== [ scan ] ====\n")

let sourceA = Observable.of(1,2,3)

sourceA.scan(0, accumulator: +)
  .subscribe(onNext:{
    print($0)
  }).disposed(by: disposeBag)

print("\n==== [ withLatestFrom ] ====\n")
