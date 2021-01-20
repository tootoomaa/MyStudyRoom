
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

protocol Language {
    var language: Hello { get }
    func greeting()
}

class Message: Language {
    
    var language: Hello
    
    init(language: Hello) {
        self.language = language
    }
    
    func greeting() {
        self.language.greeting()
    }
}

let krMessage = Message(language: Korean())
krMessage.greeting()

let engMessage = Message(language: English())
engMessage.greeting()
