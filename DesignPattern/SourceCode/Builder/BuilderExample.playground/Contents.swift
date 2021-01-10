import Foundation


class CodeBuilder : CustomStringConvertible
{
    let indent = 2
    let rootName: String
    var array = [String]()
    init(_ rootName: String)
    {
        self.rootName = rootName
    }
    
    func addField(_ name: String, _ type: String) -> CodeBuilder
    {
        self.array.append("var \(name): \(type)\n")
        return self
    }
    
    public var description: String
    {
        // todo
        var printString = "Class \(rootName)\n"
        printString.append("{\n")
        
        let padding = String(repeating: " ", count: self.indent)
        for text in array {
            printString += padding + text
        }
        printString += "}"
        
        return printString
    }
}

let cb = CodeBuilder("Person").addField("name", "String").addField("age", "Int")
print(cb.description)

