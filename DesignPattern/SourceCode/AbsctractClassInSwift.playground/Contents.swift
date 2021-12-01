import UIKit

class ConcreteAnimal {
    func sound() {
        fatalError("Subclasses need to implement the 'sound()' method")
    }
}

class ConCat: ConcreteAnimal { }
class ConDog: ConcreteAnimal { }

let conCat = ConCat()
conCat.sound()


//protocol Animal {
//    func sound()
//}
//
//class Car: Animal {
//
//}
//
//class Dog: Animal {
//
//}
