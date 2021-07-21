protocol Mediator {
    var colleague: [Colleague] { get set }
    func addColleague(obj: Colleague)
    func createColleague()  // 회원을 생성합니다.
    func mediate(data: String, userName: String)
}


class Server: Mediator {
    
    
    internal var colleague: [Colleague] = []
    
    init() {
        print("중재자 생성이 되었습니다.")
    }
    
    func addColleague(obj: Colleague) {
        self.colleague.append(obj)
    }
    
    func createColleague() {
        // 동료 객체 목록을 초기화 합니다.
    }
    
    // 중재 가능
    func mediate(data: String, userName: String) {
        print("\(userName)로 부터 서버 메시지를 통보합니다.")
        
        // 모든 Colleague에게 전달 받는 메시지를 통보합니다
        self.colleague.forEach { colleague in
            print("\(colleague.userName()) : \(colleague.message(data: data))")
        }
    }
}

// MARK: - Colleague
protocol Colleague {
    var mediator: Mediator?  { get }
    func setMediator(mediator: Mediator)
    func userName() -> String
    func send(data: String)
    func message(data: String) -> String
}

class User: Colleague {
    
    internal var mediator: Mediator?
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func setMediator(mediator: Mediator) {
        self.mediator = mediator
    }
    
    func userName() -> String {
        return self.name
    }
    
    func send(data: String) {
        self.mediator?.mediate(data: data, userName: name)
    }
    
    func message(data: String) -> String {
        return " \(data) \n"
    }
}

// 1 단계: 서버 생성
let mediator = Server()

// Collaegue 1 등록
let user1 = User(name: "James")
user1.setMediator(mediator: mediator)
mediator.addColleague(obj: user1)

// Collaegue 2 등록
let user2 = User(name: "Jiny")
user2.setMediator(mediator: mediator)
mediator.addColleague(obj: user2)


let user3 = User(name: "Pitter")
user3.setMediator(mediator: mediator)
mediator.addColleague(obj: user3)


user1.send(data: "안녕하세요, 저는 james 입니다")
user2.send(data: "안녕하세요, 저는 Jiny 입니다")
user3.send(data: "안녕하세요, 저는 Pitter 입니다")
