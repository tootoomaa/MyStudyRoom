import UIKit

// class

@objc class Person: NSObject {
    @objc dynamic var name: String?
}


let kks = Person()

kks.observe(\Person.name, options: .new) { (person, name) in
    print("I'm now called \(person.name)")
}

kks.setValue("aa", forKey: "name")
kks.setValue("bb", forKey: "name")
kks.setValue("cc", forKey: "name")
kks.setValue("dd", forKey: "name")

