

protocol Visitable {
    func accept(visitor: Visitor)
}

class Product: Visitable {
    private var name: String = ""
    private var price: Int = 0
    private var num: Int = 0
    
    // Setter: 상품명 설정
    func setName(name: String) {
        self.name = name
    }
    
    // Getter: 상품명 확인
    func getName() -> String {
        self.name
    }
    
    // Setter: 가격 설정
    func setPrice(price: Int) {
        self.price = price
    }
    // Getter: 가격 확인
    func getPrice() -> Int {
        self.price
    }
    
    // Setter: 수량 입력
    func setNum(num: Int) {
        self.num = num
    }
    // Getter: 수량 확인
    func getNum() -> Int {
        self.num
    }
    // 인터페이스 구현
    func accept(visitor: Visitor) {
        // 방문자의 주문을 호출
        // 인자로 원소 객체 자신을 전달
        return visitor.order(visitable: self)
    }
    // 행위 추가 동작
//    func getTax(by percent: Int) -> Float {
//        Float(self.price * self.num * percent/100)
//    }
}

class Cart: Product {
    // PHP 언어에서는 Protected 로 정의되어 있어
    // Product를 상속받은 변수들에 접근가능하지만
    // Swift 에서는 Protected가 없어 private로 구현함
    init(name: String, price: Int, num: Int = 1) {
        super.init()
        self.setName(name: name)
        self.setPrice(price: price)
        self.setNum(num: num)
    }
    
    func getTax(by percent: Int) -> Float {
        Float(self.getPrice() * self.getNum() * percent/100)
    }
    
    func list() -> String {
        let order = "\(getName()), 수량: \(getNum()), 총 가격 \(getPrice()*getNum()) "
        return order
    }
}

//let cart = Cart(name: "컵라면", price: 900, num: 2)
//print(cart.list())

protocol Visitor {
    func order(visitable: Visitable)
}

class Visitant: Visitor {
    
    private var total: Int
    private var num: Int
    
    init() {
        self.total = 0
        self.num = 0
    }
    
    func order(visitable: Visitable) {
        print("=== 상품 내역 ===")
        
        if let cart = visitable as? Cart {
            
            let total = cart.getNum()*cart.getPrice()
            
            print("상품명: \(cart.getName()), 수량: \(cart.getNum()), 총: \(total)")
            print("가격은 \(total) 입니다.")
            
            self.total += total
            self.num += 1 // 주문 건수 증가
        }
    }
    
    func getTotal() -> Int {
        self.total
    }
    
    func getNum() -> Int {
        self.num
    }
}

let cart = Cart(name: "컵라면", price: 900, num: 2)
//print(cart.list())
cart.accept(visitor: Visitant())
