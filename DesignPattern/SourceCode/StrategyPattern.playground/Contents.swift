// MARK: - Intro: Weapon
// 무기에 대한 인터페이스를 선언한다
protocol Weapon {
    func attack()
}

// 무기 인터페이스를 적용하여 객체의 실체 코드 구현 작성
class Gun: Weapon {
    func attack() {
        print("총을 발포합니다.\n")
    }
}

class Knife: Weapon {
    func attack() {
        print("칼을 휘두룹니다.\n")
    }
}
// MARK: - 1. Strategy
// 전략
protocol StrategyType {
    var delegate: Weapon?            { get }    // 추상적인 접근 점
    func setWeapon(weapon: Weapon)              // 무기 교환 패턴
}

class Strategy: StrategyType {
    var delegate: Weapon?
    
    // 무기 교환 패턴
    func setWeapon(weapon: Weapon) {
        print("== 무기를 교환 합니다. ==")
        self.delegate = weapon
    }
}
// 구체적인 패턴
class Charactor: Strategy {
    func attack() {
        if self.delegate == nil {
            // 무기가 선택되지 않음
            print("맨손 공격합니다.\n")
        } else {
            // delegate
            self.delegate?.attack()
        }
    }
}

let charactor = Charactor()

charactor.attack()

charactor.setWeapon(weapon: Knife())
charactor.attack()

charactor.setWeapon(weapon: Gun())
charactor.attack()
