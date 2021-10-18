import UIKit

// MARK: - Context
class Context {
    private var token: [String]
    private var index = 0

    init(text: String) {
        self.token = text.split(separator: " ").map({"\($0)"})
        print("토큰 분리")
        print(token)
    }

    func isStart() -> Bool {
        if token.first == "{{" {
            return true
        } else {
            return false
        }
    }

    func next() -> String? {
        token.removeFirst()
        return token.first ?? nil
    }
}

// MARK: - 03. Interface/Expression
protocol Expression {
    func interpret() -> String
}

class Add: Expression {
    private var left: Int
    private var right: Int
    
    init(left: Int, right: Int) {
        self.left = left
        self.right = right
    }
    
    func interpret() -> String {
        return "\(left + right)"
    }
}

class Terminal: Expression {
    private var ternaimalString: String
    
    init(char: String) {
        self.ternaimalString = char
    }
    
    func interpret() -> String {
        return ternaimalString
    }
}

let lex = "{{ 1 1 + }}" // 후위 표기법
let context = Context(text: lex)

if context.isStart() {
    
    print("연산 해석 시작 ===============\n")
    
    var stack: [String] = [] // 스택
    
    while(true) {
    
        let token = context.next()
        
        guard let token = token else {
            print("[Error] 더이상 Token이 없습니다")
            break
        }
        
        if token == "}}" {
            
            print("구문 연산 종료\n")
            break;
            
        } else if (Int(token) != nil) {
            
            print("\(token) 스택 저장")
            stack.append(token)
            
        } else if token == "+" {
            print("+ 연산")

            // 스택에서 두개의 피 연산자 읽음
            if let left = stack.popLast(),
               let right = stack.popLast() {

                guard let numLeft = Int(left),
                      let numRight = Int(right) else {
                    print("[Error] \(right), \(left)는 숫자 여야 합니다.")
                    break
                }
                
                // 비종료 연산을 수행합니다.
                let add = Add(left: numLeft, right: numRight)
                let value = add.interpret()
                print("Add 연산 결과 : \(value)")
                // 결과를 다시 스택에 저장합니다
                stack.append(value)
                
            } else {
                print("[Error]: 연산에 필요한 요소가 부족합니다.")
                break;
            }
            
        }
    }
    
    guard let result = stack.popLast() else {
        fatalError("[Error]: 최종 결과 값이 없습니다.")
    }
    
    print("최종 결과: \(result)")
}

