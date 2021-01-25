import UIKit

class Computer {
    var monitor: Monitor?
    var name = "구성"
    
    func setMoniter(monitor: Monitor) {
        self.monitor = monitor
    }
}

class Monitor {
    var name = "모니터"
}

let computer = Computer()
let monitor = Monitor()
computer.setMoniter(monitor: monitor)

print(computer.name)
print(computer.monitor?.name)

