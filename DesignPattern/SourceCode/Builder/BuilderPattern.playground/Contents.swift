import Foundation

// HTML 문법을 자동으로 생성해주는 프로그램

class HtmlElement: CustomStringConvertible {
    var name = ""
    var text = ""
    var elements = [HtmlElement]()
    
    private let indentSize = 2
    
    init() {}
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
    
    private func description(_ indent: Int) -> String {
        
        var result = ""
        let i = String(repeating: " ", count: indent)
        result += "\(i)<\(name)>\n"
        
        if !text.isEmpty {
            result += String(repeating: " ", count: indent+1)
            result += text
            result += "\n"
        }
        
        for e in elements {
            result += e.description(indent+1)
        }
        
        result += "\(i)</\(name)>\n"
        
        return result
    }
    
    public var description: String {
        return description(0)
    }
    
}

class HtmlBuilder: CustomStringConvertible {
    private let rootName: String
    var root = HtmlElement()
    
    init(rootName: String) {
        self.rootName = rootName
        root.name = rootName
    }
    
    deinit {
        print("deinit")
    }
    
    func addChild(name: String, text: String) {
        
        let e = HtmlElement(name: name, text: text)
        root.elements.append(e)
        
    }
    
    func addChildFluent(name: String, text: String) -> HtmlBuilder {
        let e = HtmlElement(name: name, text: text)
        root.elements.append(e)
        return self
    }
    
    var description: String {
        return root.description
    }
    
    func clear() {
        root = HtmlElement(name: rootName, text: "")
    }
}

func beforeMain() {
    print("====Before Main====")
    let hello = "hello"
    var result = "<p>\(hello)</p>"

    print(result)

    let words = ["hello", "world"]
    result = "<ul>\n"

    for word in words {
        result.append("<li>\(word)</li>\n")
    }
    result.append("</ul>\n")
    print(result)
}

func builderPatternMain() {
    print("====builderPattern Main====")
    let builder = HtmlBuilder(rootName: "ul")
//    builder.addChild(name: "li", text: "hello")
//    builder.addChild(name: "li", text: "word")
    
    builder
        .addChildFluent(name: "li", text: "Hello")
        .addChildFluent(name: "li", text: "word")
    
    
    
    print(builder)
}

beforeMain()
//builderPatternMain()

let builder2 = HtmlBuilder(rootName: "ul")
builder2.addChild(name: "li", text: "first Line")
builder2.addChild(name: "li", text: "Second Line")

print(builder2)
