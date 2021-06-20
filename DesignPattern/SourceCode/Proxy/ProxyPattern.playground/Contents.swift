// MARK: - Interface
protocol SubjectType {
    func isProxy() -> Bool
    func action1()
    func action2()
}

// MARK: - RealSubject
class RealSubject: SubjectType {
    
    init() {
        print(" RealSubject 객체가 생성이 되었습니다.")
    }
    
    func isProxy() -> Bool {
        false
    }
    
    func action1() {
        print("실제 \(#function) 호출..")
        print("실제 \(#function) 작업을 처리합니다.\n")
    }
    
    func action2() {
        print("실제 \(#function) 호출..")
        print("실제 \(#function) 작업을 처리합니다.\n")
    }
}

//let realSubject = RealSubject()
//realSubject.action1()
//realSubject.action2()

class Proxy: SubjectType {
    
    let realSubject: RealSubject
    
    init(realSubject: RealSubject) {
        self.realSubject = realSubject
        print("프록시 객체 생성 완료")
    }
    
    func isProxy() -> Bool {
        true
    }
    
    func action1() {
        print("프록시 \(#function) 호출..")
        self.realSubject.action1()
    }
    
    func action2() {
        print("프록시 \(#function) 호출..")
        self.realSubject.action2()
    }
}

//let real = RealSubject()
//let proxy = Proxy(realSubject: real)
//
//proxy.action1()
//proxy.action2()


///===== With Factory

class ProxyFactory {
    
    func getObject() -> SubjectType {
        let real = RealSubject()
        return Proxy(realSubject: real)
    }
    
}

//let proxyFactory = ProxyFactory()
/*
 클라이언트는 팩토리에 객체 생성만 요청할 뿐이며, 반환되는 객체가 프록시 인지 실체 객체인지 알수 없다.
 또한 실시간으로 프록시 객체를 동적 생성할 수 있다.
 */

//let obj = proxyFactory.getObject()
//obj.action1()
//obj.action2()
//obj.isProxy()

/// 305P 캐싱 처리

class NewProxy: SubjectType {
    
    private var obj: RealSubject
    
    init(real: RealSubject) {
        print("New Proxcy 생성")
        self.obj = real
    }
    
    func isProxy() -> Bool {
        true
    }
    
    func action1() {
        print("뉴프록시 \(#function) 호출..")
    }
    
    func action2() {
        print("뉴프록시 \(#function) 호출..")
//        if self.obj.action2() {
//
//        } else {
//            print("실제 객체에서 문자열을 반환 받지 못했습니다.")
//        }
    }
}


// 310P  virtual Proxy
class VirtualProxy: SubjectType {
    
    var realSubject: RealSubject?
    
    init() {
        print("프록시 객체 생성 완료")
    }
    
    func isProxy() -> Bool {
        true
    }
    
    func action1() {
        print("프록시 \(#function) 호출..")
    }
    
    func action2() {
        print("프록시 \(#function) 호출..")
        
        if self.realSubject == nil {
            self.real()
        }
        self.realSubject?.action2()
    }
    
    private func real() {
        print("RealSubject 객체를 생성합니다...")
        self.realSubject = RealSubject()
    }
}

//let virtualProxy = VirtualProxy()
//virtualProxy.action1()
//virtualProxy.action2()

// 보호용 프록시
 
let ACT1 = 0x01
let ACT2 = 0x02
let myPermit = ACT1

class ProtectProxy: SubjectType {
    
    let permit: Int
    var realSubject: SubjectType?
    var actionCount: Int
    
    init(permit: Int) {
        self.permit = permit
        self.actionCount = 0
    }
    
    func isProxy() -> Bool {
        true
    }
    
    func action1() {
        print("프록시 \(#function) 호출..")
        print("프록시 \(#function) 처리 완료..")
        self.actionCount += 1
    }
    
    func action2() {
        print("프록시 \(#function) 호출..")
        print("프록시 \(#function) 실체 객체 접근 시도..")
        
        guard self.realSubject == nil && myPermit != self.permit else {
            print("Real 객체에 접근할 권한이 없습니다.")
            return
        }
        self.real()
        self.realSubject?.action2()
    }
    
    private func real() {
        print("RealSubject 객체를 생성합니다...")
        self.realSubject = RealSubject()
    }
}

let proxy = ProtectProxy(permit: ACT2)
//proxy.action1()
//proxy.action2()


let premitProxy = ProtectProxy(permit: ACT1)
premitProxy.action1()
premitProxy.action1()
premitProxy.action2()
print("action1 횟수 : \(premitProxy.actionCount)")
