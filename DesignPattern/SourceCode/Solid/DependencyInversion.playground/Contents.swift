import Foundation

enum Relationship {
    case parent
    case child
    case sibling
}

class Person {
    var name: String = ""
    
    init(_ name: String) {
        self.name = name
    }
}

protocol ResearchFunction {
    
    func filterRelationship() -> [Person]
    
}

class Relationships: ResearchFunction {
    // low - level
    private var relations = [(Person, Relationship, Person)]()
    
    func addParentAndChild(_ p: Person, _ c: Person) {
        relations.append((p, .parent, c))
        relations.append((c, .child, p))
    }
    
    func filterRelationship() -> [Person] {
        return relations
            .filter{ $0.1 == .parent}
            .map { $0.2 }
    }
}

class Research { // high - Level
    
//    init(_ relationships: Relationships) {
//        let relations = relationships.relations
//        for r in relations where r.0.name == "John" && r.1 == .parent {
//            print("John has a child called \(r.2.name)")
//        }
//    }
    
    init(_ relationship: ResearchFunction) {
        
        for p in relationship.filterRelationship() {
            print("John has a child called \(p.name)")
        }
    }
}

let perent = Person("John")
let child1 = Person("Chris")
let child2 = Person("Matt")

let relationships = Relationships()
relationships.addParentAndChild(perent, child1)
relationships.addParentAndChild(perent, child2)

Research(relationships)
