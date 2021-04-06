import UIKit
import RxSwift
import Combine


//Observable.just(5).subscribe(onNext: {
//    print("RxSwift \($0)")
//})
//
//Just(5).sink { _ in
//    print("수신 완료")
//} receiveValue: {
//    print("Combine \($0)")
//}
//
//
//let provider = (1...10).publisher
//
//provider.sink { _ in
//    print("데이터 전달이 끝났습니다.")
//} receiveValue: { data in
//    print(data)
//}
//
//let rxProvider = Observable.from([1,2,3,4,5,6,7,8,9,10])
//
//rxProvider
//    .subscribe(onNext: {
//        print($0)
//    }, onCompleted: {
//        print("데이터 전달이 끝났습니다.")
//    })


let numberProvider = (1...10).publisher

numberProvider
    .map{"\($0)"}
    .sink {
        print("\($0), String" )
    }

print("=========== Mark =================")
let rxNumberProvider = Observable.from([1,2,3,4,5,6,7,8,9,10])

rxNumberProvider
    .map{"\($0), String"}
    .subscribe(onNext: {
        print($0)
    })
