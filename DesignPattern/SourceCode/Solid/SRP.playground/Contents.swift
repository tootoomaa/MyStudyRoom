class Journal {
    
    var entries = [String]()
    var count = 0
    
    func addEntry(_ text: String) -> Int {
        count += 1
        entries.append("\(count): \(text)")
        return count - 1
    }
    
    func removeEntry(_ index: Int) {
        entries.remove(at: index)
    }
    
    var description: String {
        return entries.joined(separator: "\n")
    }
}

class Persistence {
    func saveToFile(_ journal: Journal, _ fileName: String, _ overWrite: Bool = false) {}
    func load(_ fileName: String) {}
    func load(_ url: URL) {}
}

// 코드 실행 결과
let j = Journal()
let _ = j.addEntry("I cried today")
let bug = j.addEntry("I ate a bug")

print(j.description)

j.removeEntry(bug)
print("===")
print(j.description)

/*
1: I cried today
2: I ate a bug
===
1: I cried today
*/
