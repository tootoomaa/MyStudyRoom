import UIKit
import Combine
import RxSwift

//Subejct 타입의 externalProvider를 초기화합니다.
let externalProvider = PassthroughSubject<String, Never>()

let anyCancleable = externalProvider.sink{ stream in
        print("전달받은데이터 \(stream)")
}


externalProvider.send("A")
externalProvider.send("B")
externalProvider.send("C")
anyCancleable.cancel() //데이터 발행을 중단합니다.
externalProvider.send("D")

print("=================== Rx =======================")

let rxProvider = PublishSubject<String>()

let disposable = rxProvider.subscribe(onNext: { stream in
    print("전달받은 데이터 \(stream)")
})

rxProvider.onNext("A")
rxProvider.onNext("B")
rxProvider.onNext("C")
rxProvider.dispose() // 데이터 발행 중단.
rxProvider.onNext("A")
