import UIKit

// MARK: - Intro
var status: Bool = false

//while true {
//    // 상태값 모니터
//    print("in Loop")
//    if status {
//        hello()
//        break
//    }
//}

func hello() {
    print("안녕하세요")
}

DispatchQueue.main.asyncAfter(deadline: .now()+3) {
    status = true
}

// MARK: - Subject Protocol
protocol Subject {
    func addObserver(to observer: ObserverType)
    func deleteObserver(to observer: ObserverType)
    func notiObserver()
}

protocol ObserverType {
    var name: String { get set }
    func update()
}

class Observer: ObserverType {
    var name: String = ""
    
    func update() {
        
    }
}


// MARK: - Real Subject
class Members: Subject {
    
    // 감시자 보관
    private var objs = [ObserverType]()
    
    init() {
        print("실제 주체(\(#function)를 생성한다.")
    }
    
    // 감시자를 등록
    func addObserver(to observer: ObserverType) {
        self.objs.append(observer)
    }
    
    // 감시자를 제거
    func deleteObserver(to observer: ObserverType) {
        self.objs = self.objs.filter({ $0.name != observer.name })
    }
    
    // 변경 알림
    func notiObserver() {
        self.objs.forEach{
            print("감시자: \($0.name) 변경")
            $0.update()
        }
    }
}


// 구현체 1
class UserA: ObserverType {
    var name: String
    
    init(name: String) {
        print("\(name) 객체를 생성합니다.")
        self.name = name
    }
    
    func update() {
        print("\(#function) \(name): 을 갱신합니다.")
    }
}

// 구현체 2
class UserB: ObserverType {
    var name: String
    
    init(name: String) {
        print("\(name) 객체를 생성합니다.")
        self.name = name
    }
    
    func update() {
        print("\(#function) \(name): 을 갱신합니다.")
    }
}

print("=====감시자 패턴 실행 =====")
let subject = Members()

let userA = UserA(name: "Jiny")
subject.addObserver(to: userA)

let userB = UserB(name: "Eric")
subject.addObserver(to: userB)

subject.notiObserver()
