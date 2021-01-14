import UIKit
import XCTest

class Config {
    
    private static var instance: Config? = nil
    
    static func getInstance() -> Config {
        
        if instance == nil {
            print("객체 생성")
            self.instance = Config()
        }
        print("객체 반환")
        return self.instance ?? Config()
    }
}

var obj1 = Config.getInstance()
var obj2 = Config.getInstance()

