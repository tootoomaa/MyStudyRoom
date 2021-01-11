import UIKit

import Foundation
import XCTest

class Person : CustomStringConvertible
{
    var id: Int
    var name: String
    
    init(called name: String, withId id: Int)
    {
        self.name = name
        self.id = id
    }
    
    var description: String {
        return "\(name), \(id)"
    }
}

class PersonFactory
{
    var idIndex: Int = 0
    
    func createPerson(name: String) -> Person
    {
        let newPerson = Person(called: name, withId: idIndex)
        idIndex += 1
        return newPerson
    }
}

let pf = PersonFactory()

let p1 = pf.createPerson(name: "kim")
let p2 = pf.createPerson(name: "park")

print(p1)
print(p2)

