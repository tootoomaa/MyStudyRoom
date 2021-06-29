
protocol Command {
    func excute()
    func undo()
}

class Exec1: Command {
    
    init() {
        print("Exec1 클래스 생성")
    }
    
    func excute() {
        print("명령 1을 실행합니다.")
    }
    
    func undo() {
        print("명령 1을 취소합니다.")
    }
}

class Exec2: Command {
 
    private var reciver: Concrete
    
    init(reciver: Concrete) {
        // 실체 객체 의존성 주입
        self.reciver = reciver
    }
    
    func excute() {
        print("명령2를 실행합니다.")
        self.reciver.action1()
        self.reciver.action2()
        
        // 추가 코드 작성 가능
    }
    
    func undo() {
        print("명령 2을 취소합니다.")
    }
}

class Concrete {
    func action1() {
        print("동작1, 안녕하세요")
    }
    
    func action2() {
        print("동작2, 안녕히가세요")
    }
}

//let concrete = Concrete()
//var cmd = Exec2(reciver: concrete)
//cmd.excute()

class Invoker {
    var cmd = Dictionary<String, Command>()
    
    // 명령 객체를 저장
    func setCommand(key: String, command: Command) {
        self.cmd.updateValue(command, forKey: key)
    }
    
    // 명령 객체를 삭제
    func remove(key: String) {
        self.cmd.removeValue(forKey: key)
    }
    
    // 명령 객체를 실행
    func execute(key: String) {
        if let cmd = self.cmd[key] {
            cmd.excute()
        }
    }
}

let exec1 = Exec1()                     // 실행 객체
let receiver = Concrete()               // 실제 Action 메소드 보유
let exec2 = Exec2(reciver: receiver)    // 리시버의 Action들 실행

let invoker = Invoker()                 // Command 저장
invoker.setCommand(key: "cmd1", command: exec1)
invoker.setCommand(key: "cmd2", command: exec2)

invoker.execute(key: "cmd1")
invoker.execute(key: "cmd2")

// Mecro - 인보커 내부의 모든 명령 실행
invoker.cmd.forEach{ $0.value.excute() }
