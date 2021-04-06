import UIKit
import Combine
import RxSwift
import RxCocoa

let subject = PassthroughSubject<String, Error>()

subject.sink(receiveCompletion: { completion in
  //에러가 발생한경우도 receiveCompletion 블록이 호출됩니다.
  switch completion {
  case .failure:
    print("Error가 발생하였습니다.")
  case .finished:
    print("데이터의 발행이 끝났습니다.")
  }
}, receiveValue: { value in
  print(value)
})

//데이터를 외부에서 발행할 수 있습니다.
subject.send("A")
subject.send("B")
//데이터의 발행을 종료합니다.
subject.send(completion: .finished)

print("===============RX====================")
let rxSubject = PublishSubject<String>()

rxSubject.subscribe(onNext: { data in
    print(data)
},onError: { error in
    print("Error가 발생했습니다. \(error.localizedDescription)")
}, onCompleted: {
    print("데이터 발행이 끝났습니다.")
})

rxSubject.onNext("A")
rxSubject.onNext("B")
rxSubject.onCompleted()


print("===============Combine CurrentValueSubject====================")
//맨처음 초기값을 지정합니다.
let currentStatus = CurrentValueSubject<Bool, Error>(true)

currentStatus.sink(receiveCompletion: { completion in
  switch completion {
  case .failure:
    print("Error가 발생하였습니다.")
  case .finished:
    print("데이터의 발행이 끝났습니다.")
  }
}, receiveValue: { value in
  print(value)
})

//데이터를 외부에서 발행할 수 있습니다.
print("초기값은 \(currentStatus.value)입니다.")
currentStatus.send(false) //false 값을 주입합니다.
//value값을 변경해도 값이 발행됩니다.
currentStatus.value = true

print("===============RxSwift CurrentValueSubject====================")
var rxCurrentStatus = BehaviorSubject<Bool>(value: true)

rxCurrentStatus
    .subscribe(onNext:{ value in
        print(value)
    }, onError: { error in
        print("Error가 발생하였습니다. \(error)")
    }, onCompleted: {
        print("데이터의 발행이 끝났습니다.")
    })

//데이터를 외부에서 발행할 수 있습니다.
print("초기값은 \(String(describing: rxCurrentStatus.value))입니다.")
rxCurrentStatus.onNext(false) //false 값을 주입합니다.
//value값을 변경해도 값이 발행됩니다.
rxCurrentStatus.onNext(true)
