enum Color
{
  case red
  case green
  case blue
}

enum Size
{
  case small
  case medium
  case large
  case yuge
}

class Product
{
  var name: String
  var color: Color
  var size: Size

    // product 생성자
  init(_ name: String,
             _ color: Color,
             _ size: Size) {
    self.name = name
    self.color = color
    self.size = size
  }
}


let apple = Product("Apple", .green, .small)
let tree = Product("Tree", .green, .medium)
let house = Product("House", .blue, .large)

let products = [apple, tree, house]

// products 출력
for product in products {
    print(" - \(product.name) is \(product.color) and \(product.size)")
}

/*
- Apple is green ansd small
 - Tree is green ansd medium
 - House is blue ansd large
*/


protocol Specification {
    associatedtype T
    func isSatisfied(_ item: Product) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ items:[T], _ spec: Spec) -> [T] where Spec.T == T
}

class BetterFilter: Filter {

    typealias T = Product

    func filter<Spec: Specification>(_ items: [Product], _ spec: Spec) -> [Product] {

        var result = [Product]()

        for item in items {
            if spec.isSatisfied(item) {

                result.append(item)
            }
        }

        return result
    }
}

class ColorSpecification: Specification {
    typealias T = Product
    
    let color: Color
    
    init(_ color: Color) {
        self.color = color
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class SizeSpecification: Specification {
    typealias T = Product
    
    let size: Size
    
    init(_ size: Size) {
        self.size = size
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.size == size
    }
}

class AndSpecification<SpecA: Specification, SpecB: Specification, T>: Specification where SpecA.T == SpecB.T, SpecA.T == T
{
    typealias T = Product
    
    let specA: SpecA
    let specB: SpecB
    
    init(_ specA: SpecA, _ specB: SpecB) {
        self.specA = specA
        self.specB = specB
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return specA.isSatisfied(item) && specB.isSatisfied(item)
    }
}

print("============Better Filter ==============")
let betterFilter = BetterFilter()

for product in betterFilter.filter(products, ColorSpecification(.green)) {
    print(" - \(product.name) is \(product.color) and \(product.size)")
}


for product in betterFilter.filter(products, SizeSpecification(.large)) {
    print(" - \(product.name) is \(product.color) and \(product.size)")
}

print("========================================")
for product in betterFilter.filter(products,
                                   AndSpecification(ColorSpecification(.blue),
                                                    SizeSpecification(.large))) {
    print(" - \(product.name) is \(product.color) and \(product.size)")
}
