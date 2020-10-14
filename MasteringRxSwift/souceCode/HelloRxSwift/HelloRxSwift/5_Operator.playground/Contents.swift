import Cocoa
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

print("\n==== [ ignore ] ====\n")
let strikesIgnore = PublishSubject<String>()

strikesIgnore
  .ignoreElements()
  .subscribe { _ in
    print("[Subscription is called]")
  }.disposed(by: disposeBag)

strikesIgnore.onNext("A") // ignore
strikesIgnore.onNext("B") // ignore
strikesIgnore.onNext("C") // ignore

strikesIgnore.onCompleted()

print("\n==== [ elementAt ] ====\n")

let strikesElementAt = PublishSubject<String>()

strikesElementAt
  .elementAt(2)
  .subscribe(onNext: { _ in
    print("You are out!!!")
  }).disposed(by: disposeBag)

strikesElementAt.onNext("D") // 0
strikesElementAt.onNext("A") // 1
strikesElementAt.onNext("B") // 2 <-- Trigger
strikesElementAt.onNext("C") // ignore

print("\n==== [ filter ] ====\n")

Observable.of(1,2,3,4,5,6,7)
  .filter { $0 % 2 == 0 }
  .subscribe(onNext: { value in
    print(value)
  }).disposed(by: disposeBag)

print("\n==== [ Skip ] ====\n")

Observable.of("A", "B", "C", "D", "E", "F")
  .skip(4)
  .subscribe(onNext: {
    print($0)
  }).disposed(by: disposeBag)

print("\n==== [ skipWhile ] ====\n")

Observable.of(2,2,3,4,4)
  .skipWhile { $0 % 2 == 0 }
  .subscribe ( onNext: {
    print($0)
  }).disposed(by: disposeBag)

print("\n==== [ skipUntil ] ====\n")

let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.skipUntil(trigger)
  .subscribe(onNext: {
    print($0)
  }).disposed(by: disposeBag)

subject.onNext("A")
subject.onNext("B")

trigger.onNext("X")

subject.onNext("C")

print("\n==== [ take ] ====\n")

Observable.of(1,2,3,4,5,6)
  .take(3)
  .subscribe(onNext: {
    print($0)
  }).disposed(by: disposeBag)

print("\n==== [ takeWhile ] ====\n")

Observable.of(2,4,6,7,8,10)
  .takeWhile {
    return $0 % 2 == 0
  }.subscribe(onNext: {
    print($0)
  }).disposed(by: disposeBag)

print("\n==== [ takeUntil ] ====\n")

let subject2 = PublishSubject<String>()
let trigger2 = PublishSubject<String>()

subject2.takeUntil(trigger2)
  .subscribe(onNext:{
    print($0)
  }).disposed(by: disposeBag)

subject2.onNext("1")
subject2.onNext("2")

trigger2.onNext("X")

subject2.onNext("3")

