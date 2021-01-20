import UIKit

protocol Hello {
    func greeting()
}

class English: Hello {
    func greeting() {
        print("Hello")
    }
}

class Korean: Hello {
    func greeting() {
        print("안녕하세요")
    }
}

let korean = Korean()
korean.greeting()

let english = English()
english.greeting()


class Langhuage {
    
    var hello: Hello
    
    init(hello: Hello) {
        self.hello = hello
    }
}

let koLanguage = Langhuage(hello: Korean())
koLanguage.hello.greeting()

let enLanguage = Langhuage(hello: English())
enLanguage.hello.greeting()
