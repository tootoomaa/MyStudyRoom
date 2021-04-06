import Combine
import RxSwift
import Foundation // number Formatter

// combine
let provider = (1...10).publisher

let formatter = NumberFormatter()
formatter.numberStyle = .ordinal

provider.map {
    formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
}.sink {
    print("Change Value : \($0)")
}

print("=================================")
// RxSwift
let rxProvider = Observable.from([1,2,3,4,5,6,7,8,9,10])

rxProvider
    .map{ formatter.string(from: NSNumber(integerLiteral: $0)) ?? "" }
    .subscribe(onNext: {
        print($0)
    })
