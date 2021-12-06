import UIKit

/* Reference
 https://medium.com/@jgj455/오늘의-swift-상식-subscript-2288551588f9
 
 */

// MARK: - Normal subScript Test

struct TimeTable<Value: Numeric> {
    let multiplier: Value
    subscript(index: Value) -> Value {
        get { index * multiplier }
    }
}

let mulThreeTable = TimeTable(multiplier: 3)
print("Six times three is \(mulThreeTable[6])")

let mulThreeDoubleTable = TimeTable(multiplier: 0.3)
print("0.5 time 0.3 is \(mulThreeDoubleTable[3.0])")


// MARK: -

struct State {
    var value1 = 1
    var value2 = 2
    var value3 = 3
}

struct MultiNumberBox {
    let number: Int
    subscript(index: Int) -> Int {
        get { number * index }
    }
}

let multiNumberBox = MultiNumberBox(number: 5)
print("\(multiNumberBox[4])")
