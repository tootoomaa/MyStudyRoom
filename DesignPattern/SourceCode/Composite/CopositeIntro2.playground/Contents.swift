import UIKit

class Disk {
    var name: String = "디스크"
}

class Memory {
    var name: String = "메모리"
}

class Monitor {
    var name = "모니터"
}

class Computer {
    
    var monitor: Monitor?
    var disk: Disk?
    var memory: Memory?
    
    var name: String = "구성"
    
    func setMonitor(_ monitor: Monitor) {
        self.monitor = monitor
    }
    
    func setDisk(_ disk: Disk) {
        self.disk = disk
    }
    
    func setMemory(_ memory: Memory) {
        self.memory = memory
    }
    
}


let computer = Computer()
let disk = Disk()
let memory = Memory()
let monitor = Monitor()

computer.setDisk(disk)
computer.setMemory(memory)
computer.setMonitor(monitor)

print(computer.name)
print(computer.disk?.name)
print(computer.memory?.name)
print(computer.monitor?.name)

