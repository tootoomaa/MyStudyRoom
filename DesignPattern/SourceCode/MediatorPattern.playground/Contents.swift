protocol Mediator {
    var colleague: [Colleague] { get set }          // 회원을 관리할 배열
    func addColleague(obj: Colleague)               // 회원 추가
    func createColleague()                          // 회원을 생성합니다.
    func mediate(data: String, userName: String)    // 중재 기능
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
        // 동료 객체를 생성합니다.
    }
    
    /// 중재 기능
    /// - Parameters:
    ///   - data: 전송할 데이터
    ///   - userName: 데이터를 전송하는 사용자 이름
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
    init(name: String)
    var mediator: Mediator?  { get }        // 중개 객체
    func setMediator(mediator: Mediator)    // 중개 객체 설정
    func userName() -> String               // 동료 객체 이름
    func send(data: String)                 // 중개 객제로 데이터 전송
    func message(data: String) -> String    // 메시지 출력 확인용
}

class User: Colleague {
    
    internal var mediator: Mediator?
    private var name: String
    
    required init(name: String) {
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

// Collaegue 3 등록
let user3 = User(name: "Pitter")
user3.setMediator(mediator: mediator)
mediator.addColleague(obj: user3)


user1.send(data: "안녕하세요, 저는 james 입니다")
user2.send(data: "안녕하세요, 저는 Jiny 입니다")
user3.send(data: "안녕하세요, 저는 Pitter 입니다")
