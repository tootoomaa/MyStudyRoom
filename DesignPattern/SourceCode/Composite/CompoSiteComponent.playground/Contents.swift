import UIKit

class Component {
    
    private var name: String = ""
    
    func getName() -> String {
        return self.name
    }
    
    func setName(_ name: String) {
        self.name = name
    }
}

class Leaf: Component {
    
    private var price: Int
    
    init(_ price: Int) {
        self.price = price
    }
    
    func getPrice() -> Int {
        return self.price
    }
    
    func setPrice(_ price: Int) {
        self.price = price
    }
}

class Composite: Component {
    
    var children: [String: Component] = [:]
    
    init(_ name: String) {
        super.init()
        self.setName(name)
    }
    
    func addNode(_ folder: Component) {
        let name = folder.getName()
        self.children[name] = folder
    }
    
    func removeNode(_ folder: Component) {
        let name = folder.getName()
        children.removeValue(forKey: name)
    }
    
    func isNode() -> [String: Component] {
        return self.children
    }
}

// 폴더
let root = Composite("root")

let tmep = Composite("temp")

let home = Composite("home")

let project = Composite("Project")

let hojin = Composite("hojin")
let jiny = Composite("jiny")

let products = Composite("products")

let product1 = Leaf(10)
product1.setName("사탕")
let product2 = Leaf(20)
product2.setName("초콜렛")
let product3 = Leaf(30)
product3.setName("과자")
let product4 = Leaf(40)
product4.setName("땅콩")

root.addNode(home)
root.addNode(tmep)
root.addNode(project)

home.addNode(products)
home.addNode(hojin)
home.addNode(jiny)

products.addNode(product1)
products.addNode(product2)
products.addNode(product3)
products.addNode(product4)

jiny.addNode(product2)
jiny.addNode(product4)

hojin.addNode(product1)
hojin.addNode(product3)

func treeCheck(_ componet: Component) {
    
    let emptyString = "... 노드 없음"
    // folder 확인
    if let composite = componet as? Composite {
        
        let arr = composite.children
        
        var printString = "Folder: \(composite.getName())"
        if arr.count == 0 {
            printString.append(emptyString)
        }
        
        print(printString)
        
        arr.forEach {
            
            if let composite = $0.value as? Composite {
                
                treeCheck(composite)
                
            } else if let leaf = $0.value as? Leaf {
                
                print("File = \(leaf.getName()) , \(leaf.getPrice())")
                
            }
            
        }
        
    }
    
}

treeCheck(root)
home.removeNode(hojin)
print("\n\n==== hojin 삭제 완료 ====\n")
treeCheck(root)
