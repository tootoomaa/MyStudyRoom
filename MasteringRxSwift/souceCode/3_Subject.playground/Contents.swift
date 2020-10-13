import RxSwift
import RxCocoa

let disposeBag = DisposeBag()
print("====Publish Subject====\n")
let subject = PublishSubject<String>()

subject.onNext("Issue 1")

subject.subscribe { event in
   print(event)
}

subject.onNext("Issue 2")
subject.onNext("Issue 3")

subject.dispose()

//subject.onCompleted()

subject.onNext("Issue 4")

print("\n====Behavior Subject====\n")
// Behavior Subject

let subjectBe = BehaviorSubject(value: "Initial Value")

subjectBe.onNext("Last Issue")

subjectBe.subscribe { event in
  print(event)
}

subjectBe.onNext("Issue 1")


print("\n====Replay Subject====\n")

let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("Issue 1")
replaySubject.onNext("Issue 2")
replaySubject.onNext("Issue 3")

print("[Subscribe1]")
replaySubject.subscribe {
  print($0)
}

print("[onNext]")
replaySubject.onNext("Issue 4")
replaySubject.onNext("Issue 5")
replaySubject.onNext("Issue 6")

print("[Subscribe2]")
replaySubject.subscribe {
  print($0)
}

print("\n====variable====\n")

print("==== String ====")
let variable = Variable("Initial Value")
variable.value = "Hello world"
variable.asObservable()
  .subscribe {
    print($0)
  }

print("==== [String] ====")
let variable2 = Variable([String]())
variable2.value.append("Item 1")
variable2.asObservable()
  .subscribe {
    print($0)
  }
variable2.value.append("Item 2")

print("\n====Behavior Relay====\n")

let relay = BehaviorRelay(value: ["Item 1"])

var value = relay.value
value.append("Item 2")
value.append("Item 3")
value.append("Item 4")

relay.accept(value)

//relay.value.append("Item 1")
relay.accept(["item 2"])
//relay.accept(relay.value + ["Item 2"])

relay.asObservable()
  .subscribe {
    print($0)
  }

//relay.value = "Hello world"
//relay.accept("Hello world")


