import UIKit

class Rectangle: CustomStringConvertible {
    var _width = 0
    var _height = 0
    
    var width: Int {
        get { return _width }
        set(value) { _width = value }
    }
    
    var height: Int {
        get { return _height }
        set(value) { _height = value }
    }
    
    init() {}
    init(_ width: Int, _ height: Int) {
        _width = width
        _height = height
    }
    
    var area: Int {
        return width*height
    }
    
    public var description: String {
        return "Width: \(width), height: \(height)"
    }
}

class Square: Rectangle {
    
    override var width: Int {
        get { return _width }
        set(value) {
            _width = value
            _height = value
        }
    }
    
    override var height: Int {
        get { return _height }
        set(value) {
            _width = value
            _height = value
        }
    }
}

func setAndMeasure(_ rc: Rectangle) {
    rc.width = 3
    rc.height = 4
    
    print("Expected area to be 12 but got \(rc.area)")
}

//print("------ Rectangle ------")
//let rc = Rectangle()
//setAndMeasure(rc)
//
//print("\n------ Square ------")
//let square = Square()
//setAndMeasure(square)
//

protocol 사각형 {
  var 넓이: Float { get }
}

class 직사각형: 사각형 {
  private let 너비: Float
  private let 높이: Float
  
  init(너비: Float, 높이: Float) {
    self.너비 = 너비
    self.높이 = 높이
  }
  
  var 넓이: Float {
    return 너비 * 높이
  }
}

class 정사각형: 사각형 {
  private let 변의길이: Float
  
  init(변의길이: Float) {
    self.변의길이 = 변의길이
  }
  
  var 넓이: Float {
    return 변의길이 * 변의길이
  }
}

func printArea(rec: 사각형) {
    print(rec.넓이)
}

let 뉴직사각형 = 직사각형(너비: 5, 높이: 10)
let 뉴정사각형 = 정사각형(변의길이: 5)

printArea(rec: 뉴직사각형)
printArea(rec: 뉴정사각형)
