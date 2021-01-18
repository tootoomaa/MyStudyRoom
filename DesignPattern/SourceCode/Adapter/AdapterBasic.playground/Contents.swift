import UIKit

// 현제 코드
class Math {
    
    func twoTime(num: Float) -> Float {
        print("실수 2배 적용합니다")
        return num*2
    }
    
    func halfTime(num: Float) -> Float {
        print("실수 1/2배 적용합니다")
        return num/2
    }
    
}

// 시스템의 변화!
//

protocol Adapter {
    func twiceOf(num: Int) -> Int
    func halfOf(num: Int) -> Int
}

class Objects: Adapter {
    
    private var adapter: Math
    
    init() {
        adapter = Math()
    }
    
    func twiceOf(num: Int) -> Int {
        print("정수 2배 적용합니다")
        
        let result = self.adapter.twoTime(num: Float(num))
        
        return Int(result)
    }
    
    func halfOf(num: Int) -> Int {
        print("정수 1/2배 적용합니다.")
        
        let result = self.adapter.halfTime(num: Float(num))
        
        return Int(result)
    }
}

let obj = Objects()

obj.halfOf(num: 10)
obj.twiceOf(num: 20)
