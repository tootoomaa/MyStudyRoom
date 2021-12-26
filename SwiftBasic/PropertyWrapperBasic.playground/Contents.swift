import SwiftUI

/*
 A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property.
 */
// MARK: - 기본적인 선언
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        // getter 는 저장된 값 return
        get { number }
        // setter 는 12보다 작은 값을 보장
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)

rectangle.height = 10
print(rectangle.height)

rectangle.height = 24
print(rectangle.height)

// MARK: - 구조체를 통해 명시적으로 선언
// Property Value는 Struct임으로 아래와 같이 작성이 가능하다.
struct SmallStructRectangle {
    private var _height = TwelveOrLess()    // 구조체를 명시적으로 선언
    private var _width = TwelveOrLess()     //
    
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}

// MARK: - 다양한 init
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

// MARK: - Case init()
// init() 을 통해서 설정한 경우
// number = 0 , maximum = 12 으로 설정됨
var zeroRectangle = ZeroRectangle()
print(zeroRectangle.width, zeroRectangle.height)

// MARK: - Case init(wrappedValue: Int)
// init(wrappedValue: Int) 을 통해서 설정한 경우
// 입력한 값이 내부 변수에 저장됨
struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)

// MARK: - Case init(wrappedValue: Int, maximum: Int)
/*
 @SmallNumber 프로퍼티값 내부의 maximum 또한 외부에서 설정하여
 최대 값을 정의하는대로 사용 가능
 */
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)

narrowRectangle.height = 100 // height 최대값으로 인해 5로 설정
narrowRectangle.width = 100  // width 최대값으로 인해 4로 설정
print(narrowRectangle.height, narrowRectangle.width)

// MARK: - Projecting a Value From a Property Wrapper
@propertyWrapper
struct CustomSmallNumber {
    
    private var number: Int
    var projectedValue: Bool
    
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    
    init() {
        self.number = 0
        self.projectedValue = false
    }
}

struct SomeStructure {
    @CustomSmallNumber var someNumber: Int
}

var someStructure = SomeStructure()
someStructure.someNumber = 4
print(someStructure.$someNumber)

someStructure.someNumber = 55
print(someStructure.$someNumber)

