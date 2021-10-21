import UIKit

class Fruit {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getName() -> String {
        return self.name
    }
}


//let fruits = [Fruit(name: "Apple"),
//              Fruit(name: "Banana"),
//              Fruit(name: "Berry"),
//              Fruit(name: "Grape")]
//

//for fruit in fruits {
//    print(fruit.name)
//}

protocol Aggregate {
    func iterator()  -> PloyIterator
    func getObj(id: Int) -> Fruit
    func getAllcount() -> Int
    func append(fruit: Fruit)
}

class Collection: Aggregate {
    
    private var objc = [Fruit]()
    private var last: Int = 0
    
    // 집합에서 하나의 객체를 반환
    func getObj(id: Int) -> Fruit {
        return self.objc[id]
    }
    // 전체 객체의 갯수 반환
    func getAllcount() -> Int {
        return self.last
    }
    // 객체 추가
    func append(fruit: Fruit) {
        self.objc.append(fruit)
        self.last += 1
    }
    
    func iterator() -> PloyIterator {
        return IteratorObject(self)
    }
    
}

protocol PloyIterator {
    func isNext() -> Bool
    func next() -> Fruit
}

class IteratorObject: PloyIterator {
    
    private var aggregate: Aggregate
    private var index: Int = 0
    
    init(_ agg: Aggregate) {
        self.aggregate = agg
    }

    func isNext() -> Bool {
        
        if self.index >= self.aggregate.getAllcount() {
            return false
        } else {
            return true
        }
    }
    
    func next() -> Fruit {
        let obj = self.aggregate.getObj(id: index)
        index += 1
        return obj
    }
    
}


let menu = Collection()
menu.append(fruit: Fruit(name: "Apple"))
menu.append(fruit: Fruit(name: "Banana"))
menu.append(fruit: Fruit(name: "Berry"))
menu.append(fruit: Fruit(name: "Grape"))

let loop: PloyIterator = menu.iterator()

while loop.isNext() {
    let item = loop.next()
    print(item.name)
}
