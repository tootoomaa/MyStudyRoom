// MARK: - Memento - 01 Hello
class Hello {

    private var message: String

    init(msg: String) {
        self.message = msg
    }

    func setMessage(msg: String) {
        self.message = msg
    }

    func getMessage() -> String {
        return self.message
    }
    
    func clone() -> Hello {
        return Hello(msg: self.getMessage())
    }
}
//
//let obj = Hello(msg: "안녕하세요")
//print(obj.getMessage())
//
//obj.setMessage(msg: "Hello nice to meet you")
//print(obj.getMessage())

// MARK: - Memento Class

class Memento<T> {
    
    private var obj: T        // 객체를 저장한다
    
    init(obj: T) {            // 원조본에 의해서 생성됨
        self.obj = obj        // 객체를 복제한다.
    }
    
    func getObject() -> T {   // 저장된 객체를 읽어온다.
        return self.obj
    }
}

// MARK: - Originator
// 상태를 가지고 있는 객체 입니다.
class Originator<T> {
    
    // 상태를 저장하기 위해 변수를 하나 더 가지고 있습니다
    private var state: T?
    
    // About Memento
    // 메멘토 객체응 생성해 반환합니다
    func create() -> Memento<T>? {
        
        guard let newStat = self.state else {
            print("메멘토 객체 생성에 필패했습니다. State를 먼저 설정해주세요")
            return nil
        }
        
        print("메멘토 객체를 생성해 반환합니다.")
        return Memento(obj: newStat)
    }
    
    // 복원 합니다
    func restore(memento: Memento<T>) {
        print("메멘토 객체를 복원합니다.")
        self.state = memento.getObject()
    }
    
    // Abount State
    // 상태를 읽어옵니다
    func getState() -> T? {
        self.state
    }
    // 상태를 설정합니다.
    func setState(state: T) {
        self.state = state
    }
}

// MARK: - 실습

//let origin = Originator<Hello>()
//
//var obj = Hello(msg: "상태1: 안녕하세요")
//print(obj.getMessage())
//
//// 상태 1을 설정하고, 원조본을 메멘토에 저장합니다.
//origin.setState(state: obj.clone())
//let memento = origin.create()
//
//// 상태 변경 - 두 번째 인사말
//obj.setMessage(msg: "상태2: Hello Nice to meet you")
//print(obj.getMessage())
//
//
//// 메멘토를 통해 상태 1을 복원합니다
//if let memento = memento {
//    origin.restore(memento: memento)
//}
//
//if let state = origin.getState() {
//    state.getMessage()
//    obj = state
//}
//
//print(obj.getMessage())

// MARK: - CareTaker

class CareTaker<T> {
    
    private var stack: [Memento<T>]
    
    init() {
        self.stack = []
    }
    
    // 스택에 저장합니다.
    func push(origin: Originator<T>) {
        // 원조본을 이용하여 메멘토의 인스턴스를 생성합니다.
        if let memento = origin.create() {
            
            // 메멘토를 스택에 저장합니다.
            self.stack.append(memento)
        }
    }
    
    func undo(origin: Originator<T>) -> T? {
        // 스택에서 메멘토를 불러옵니다
        if let memento = stack.popLast() {
            // 메멘토를 이용하여 원조본을 복원합니다
            origin.restore(memento: memento)
            
            // 복원된 객체를 반환합니다
            return origin.getState()
        }
        print("메멘토 복원에 실패합니다.")
        return nil
    }
}

// MARK: - 실습 2

// 원조본, 케어테이커 객체를 생성
let careTaker = CareTaker<Hello>()
let origin = Originator<Hello>()

// 상태 1을 설정하고, 원조본을 메멘토에 저장합니다.
var obj = Hello(msg: "상태1: 안녕하세요")
print(obj.getMessage())

// 원조본에 상태1 객체를 설정, 저장합니다.
origin.setState(state: obj.clone())
careTaker.push(origin: origin)

// 상태 변경 - 두 번째 인사말
// 상태2를 설정하고, 메멘토를 통해 원조본을 케어테이커에 저장합니다.
obj.setMessage(msg: "상태2: Hello Nice to meet you")
print(obj.getMessage())

// 원조본에 상태2 객체를 설정, 저장합니다.
origin.setState(state: obj.clone())
careTaker.push(origin: origin)

// 상태 변경 - 세번째 인사말
// 상태3를 설정하고, 메멘토를 통해 원조본을 케어테이커에 저장합니다.
obj.setMessage(msg: "상태3: 구텟베르겐")
print(obj.getMessage())

// 원조본에 상태3 객체를 설정, 저장합니다.
origin.setState(state: obj.clone())
careTaker.push(origin: origin)

/// -----
// 메멘토를 통해서 상태3 복원
obj = careTaker.undo(origin: origin)!
print(obj.getMessage())

// 메멘토를 통해서 상태2 복원
obj = careTaker.undo(origin: origin)!
print(obj.getMessage())

// 메멘토를 통해서 상태1 복원
obj = careTaker.undo(origin: origin)!
print(obj.getMessage())
