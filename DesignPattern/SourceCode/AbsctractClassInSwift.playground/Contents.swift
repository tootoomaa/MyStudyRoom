import UIKit

class Animal {
    func sound() {}
}

class Cat: Animal {
    override func sound() {
        print("miauw")
    }
}

class Dog: Animal {
    override func sound() {
        print("woof")
    }
}

