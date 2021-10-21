// MARK: - 1. Basic SandWitch
//class SandWich {
//    func make() -> String {
//        return "빵 + 속재료 + 빵";
//    }
//}
//let sandWitch = SandWich()
//print(sandWitch.make())

// MARK: - 2. Improve SandWich
//class SandWich {
//    func make() -> String {
//        var food: String = ""
//
//        // 1단계: 빵을 하나 준비합니다.
//        food += "빵"
//
//        // 2단계: 준비된 빵에 속재료를 올려 놓습니다
//        food += " + "
//        food += "속재료"
//
//        // 3단계: 속재료 위에 다시 빵 하나를 놓습니다.
//        food += " + "
//        food += "빵"
//
//        return food
//    }
//}
//
//let sandWitch = SandWich()
//print(sandWitch.make())

// MARK: - 3. More Improve SandWich
//class SandWich {
//    func make() -> String {
//        var food: String = ""
//
//        // 1단계: 빵을 하나 준비합니다.
//        food += self.bread()
//
//        // 2단계: 준비된 빵에 속재료를 올려 놓습니다
//        food += " + "
//        food += self.jam()
//
//        // 3단계: 속재료 위에 다시 빵 하나를 놓습니다.
//        food += " + "
//        food += self.bread()
//
//        return food
//    }
//
//    func bread() -> String {
//        "식빵"
//    }
//
//    func jam() -> String {
//        "딸기잼"
//    }
//}
//
//let sandWitch = SandWich()
//print(sandWitch.make())

// MARK: - 4. Common Extract to Class
//class Strawberry {
//    func bread() -> String { "식빵" }
//    func jam() -> String { "딸기잼" }
//}
//
//class SandWich {
//    let strawberry = Strawberry()
//
//    func make() -> String {
//        var food: String = ""
//
//        // 1단계: 빵을 하나 준비합니다.
//        food += strawberry.bread()
//
//        // 2단계: 준비된 빵에 속재료를 올려 놓습니다
//        food += " + "
//        food += strawberry.jam()
//
//        // 3단계: 속재료 위에 다시 빵 하나를 놓습니다.
//        food += " + "
//        food += strawberry.bread()
//
//        return food
//    }
//}
//
//let sandWich = SandWich()
//print(sandWich.make())

// MARK: - 5. override
//class Strawberry {
//    func bread() -> String { "식빵" }
//    func jam() -> String { "딸기잼" }
//}
//
//class StrawberryBagle: Strawberry {
//    override func bread() -> String { "베이글" }
//}
//
//class SandWich {
//    let maker: Strawberry
//
//    init(maker: Strawberry) {
//        self.maker = maker
//    }
//
//    func make() -> String {
//        var food: String = ""
//
//        // 1단계: 빵을 하나 준비합니다.
//        food += maker.bread()
//
//        // 2단계: 준비된 빵에 속재료를 올려 놓습니다
//        food += " + "
//        food += maker.jam()
//
//        // 3단계: 속재료 위에 다시 빵 하나를 놓습니다.
//        food += " + "
//        food += maker.bread()
//
//        return food
//    }
//}
//
//let sandWich = SandWich(maker: StrawberryBagle())
//print(sandWich.make())


// MARK: - 6. Abstract
protocol SandWitchMaker {
    func bread() -> String
    func jam() -> String
}

class SandWich {

    private let maker: SandWitchMaker

    init(maker: SandWitchMaker) {
        self.maker = maker
    }

    func make() -> String {
        var food: String = ""

        // 1단계: 빵을 하나 준비합니다.
        food += maker.bread()

        // 2단계: 준비된 빵에 속재료를 올려 놓습니다
        food += " + "
        food += maker.jam()

        // 3단계: 속재료 위에 다시 빵 하나를 놓습니다.
        food += " + "
        food += maker.bread()

        return food
    }
}

class Strawberry: SandWitchMaker {
    func bread() -> String { "식빵" }
    func jam() -> String { "딸기잼" }
}

class StrawberryBagle: SandWitchMaker {
    func bread() -> String { "베이글" }
    func jam() -> String { "딸기잼" }
}

let sandWichWithBagle = SandWich(maker: StrawberryBagle())
print(sandWichWithBagle.make())

let sandWichWithBread = SandWich(maker: Strawberry())
print(sandWichWithBread.make())
