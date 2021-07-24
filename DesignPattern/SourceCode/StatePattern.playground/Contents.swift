
//let state = true
//
//if state {
//    print("참 입니다.")
//} else {
//    print("거짓 입니다.")
//}


// MARK: - Class 로 변경 : 별 차이 없음
//class JinyOrder {
//    let OPEN    = 0x01  // 주문
//    let PAY     = 0x02  // 결제중
//    let ORDERED = 0x04  // 주문완료
//    let FINISH  = 0x08  // 처리완료
//
//    func process(state: String) {
//        switch state {
//        case "OPEN":
//            self.stateOrder()
//        case "PAY":
//            self.statePAY()
//        case "ORDERED":
//            self.stateORDERED()
//        case "FINISH":
//            self.stateFINISH()
//        default:
//            break
//        }
//    }
//
//    func stateOrder() {
//        print("주문")
//    }
//
//    func statePAY() {
//        print("결제중")
//    }
//
//    func stateORDERED() {
//        print("주문완료")
//    }
//
//    func stateFINISH() {
//        print("처리완료")
//    }
//
//}
//
//let jinyOrder = JinyOrder()
//jinyOrder.process(state: "FINISH")

// MARK: - 개선

protocol State {
    func process()
}

class StateOrder: State {
    func process() {
        print("주문")
    }
}

class StatePay: State {
    func process() {
        print("결제중")
    }
}

class StateOrdered: State {
    func process() {
        print("주문완료")
    }
}

class StateFinish: State {
    func process() {
        print("처리완료")
    }
}


class JinyOrder {
    
    private var states = [String:State]()
    
    let OPEN    = 0x01  // 주문
    let PAY     = 0x02  // 결제중
    let ORDERED = 0x04  // 주문완료
    let FINISH  = 0x08  // 처리완료

    init() {
        states = [
            "OPEN"      : StateOrder(),
            "PAY"       : StatePay(),
            "ORDERED"   : StateOrdered(),
            "FINISH"    : StateFinish()
        ]
    }
    
    func process(state: String) {
        self.states[state]?.process()
    }
}

let jinyOrder = JinyOrder()
jinyOrder.process(state: "FINISH")

// MARK: - Light

protocol LightState {
    func lightOn()
    func lightOff()
    func lightState() -> Bool
}

class LightLamp: LightState {
    // 전구의 초기 상태는 off
    private var lightSate: Bool = false
    
    init() {
        print("객체를 생성합니다.")
    }
    
    // 전구 On
    func lightOn() {
        print("전구를 on 합니다")
    }
    // 전구 Off
    func lightOff() {
        print("전구를 off 합니다")
    }
    
    // 전구의 상태값 반환
    func lightState() -> Bool {
        return self.lightSate
    }
}

let lightLamp = LightLamp()
lightLamp.lightOn()
lightLamp.lightOff()

lightLamp.lightOn()
lightLamp.lightOn()
