import Foundation

//=========== Abstract Factory

protocol HotDrink {
    func consume()
}

class Tea: HotDrink {
    func consume() {
        print("This tea is nice but I'd prefer it with milk")
    }
}

class Coffee: HotDrink {
    func consume() {
        print("This coffee is delicious")
    }
}

protocol HotDrinkFactory {
    init()
    func prepare(amount: Int) -> HotDrink
}

class TeaFactory: HotDrinkFactory {
    required init() {}
    func prepare(amount: Int) -> HotDrink {
        print("Put in tea bag, boil water, pour \(amount)ml, add lemon, enjoy!")
        return Tea()
    }
}

class CoffeeFactory: HotDrinkFactory {
    required init() {}
    func prepare(amount: Int) -> HotDrink {
        print("Grind some beans, boil water, pour \(amount)ml, add sugur, enjoy!")
        return Coffee()
    }
}

class HotDrinkMachine {
    enum AvailableDrink: String { // break OCP
        case coffee = "Coffee"
        case tea = "Tea"

        static let all = [coffee, tea]
    }

    internal var factories = [AvailableDrink: HotDrinkFactory]()

    internal var namedFactories = [(String, HotDrinkFactory)]()

    init() {

        namedFactories.append(("tea", TeaFactory.init()))
        namedFactories.append(("coffee", CoffeeFactory.init()))

    }

    func makeDrink() -> HotDrink {
        print("Available drinks:")

        for i in 0..<namedFactories.count {
            let tuple = namedFactories[i]
            print("\(i): \(tuple.0)")
        }
        
        let select = readLine()
        guard let index = Int(select ?? " ") else {
            fatalError("Input Only Int")
        }

        return namedFactories[index].1.prepare(amount: 200)
    }
}

let machine = HotDrinkMachine()
let drink = machine.makeDrink()

drink.consume()

