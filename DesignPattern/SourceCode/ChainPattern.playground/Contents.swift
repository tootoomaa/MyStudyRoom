// MARK: - 1. 조건문
let conf = true

if conf {
    // 조건이 참인 경우 코드 분기
    ordered()
} else {
    // 조건이 거짓인 경우 코드 분기
    cancel()
}

func ordered() {
    print("주문이 성공적으로 접수 되었습니다.")
}

func cancel() {
    print("주문을 취소합니다.")
}

// MARK: - 2. 메시지
class Cart {
    func ordered() {
        print("장바구니 상품을 성공적으로 주문 접수했습니다.")
    }
    
    func cancel() {
        print("장바구니 상품 주문을 취소합니다.")
    }
}


let cart = Cart()

let conf2 = false

if conf2 {
    //조건이 참인 경우
    //메시지를 전송합니다.
    cart.ordered()
} else {
    //조건이 거짓인 경우
    //메시지를 전송합니다.
    cart.cancel()
}

// MARK: - 3. Handler
class Handler {
    func event(message: String) -> String {
        if message == "action01" {
            return "버튼 동작 01입니다."       // 책임 동작 1
        } else if message == "action02" {
            return "버튼 동작 02입니다."       // 책임 동작 2
        } else if message == "action03" {
            return "버튼 동작 03입니다."       // 책임 동작 3
        }
        
        return "동작이 없습니다."
    }
}

let handler = Handler()
print(handler.event(message: "action01"))

// MARK: - Chain

class Order {
    func execute() -> String {
        return "주문을 처리합니다."
    }
}

class Cancel {
    func cancel() -> String {
        return "장바구니 상품 주문을 취소합니다."
    }
    func execute() -> String {
        return "장바구니 상품 주문을 취소합니다."
    }
}

class ChainHandler {
    
    func event(message: String) -> String {
        if message == "order" {
            return Order().execute()
        } else if message == "cancel" {
            return Cancel().cancel()
        }
        return "동작이 없습니다."
    }
    
    func newEvent(message: String) -> String {
        if message == "order" {
            return Order().execute()
        } else if message == "cancel" {
            return Cancel().cancel()
        }
        return "동작이 없습니다."
    }
}

let chainHandler = ChainHandler()
print(chainHandler.event(message: "order"))

// MARK: - Chain send receive separate

class SeperateHandler {
    func event(message: String) -> String {
        
        if let message = NewOrder().execute(message: message) {
            return message
        }
        if let message = NewCancel().execute(message: message) {
            return message
        }
        return "동작이 없습니다."
    }
}

class NewOrder {
    func execute(message: String) -> String? {
        if message == "order" {
            return "주문을 처리합니다."
        }
        return nil
    }
}

class NewCancel {
    func execute(message: String) -> String? {
        if message == "cancel" {
            return "취소 처리합니다."
        }
        return nil
    }
}

let speHandler = SeperateHandler()
print(speHandler.event(message: "cancel"))

// MARK: - Chain Example

protocol Chain {
    var next: Chain                 { get }
    init(chain: Chain)
    func excute(evnet: String) -> String
}

class ConcreateChain: Chain {
    var next: Chain
    
    required init(chain: Chain) {
        self.next = chain
    }

    func excute(evnet: String) -> String {
        return next.excute(evnet: evnet)
    }
}

