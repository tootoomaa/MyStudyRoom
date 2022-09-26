//
//  MotionManager.swift
//  WatchTest
//
//  Created by 김광수 on 2022/09/02.
//

import Foundation
import CoreMotion

class MotionManager: ObservableObject {
    
    let motionManagerDelegate = CMMotionManager()
    var sensorDataDelegate = [Double]()
    @Published var statusString: String = ""
    @Published var value: String = "Before start"
    var timer: Timer?
    
    init() {
        // 모션 활동이 지원 되는 기기 인지 확인
        if self.motionManagerDelegate.isDeviceMotionAvailable {
            self.statusString = "Available"
            // 모션 활동이 켜져 있는지 확인
            if !self.motionManagerDelegate.isDeviceMotionActive {
                self.motionManagerDelegate.showsDeviceMovementDisplay = true
            }
            
        } else {
            self.statusString = "Not Availalbe"
        }
        
    }
    
    func startMotionTracking() {
        self.motionManagerDelegate.gyroUpdateInterval = 1.0 / 60.0
        self.motionManagerDelegate.startGyroUpdates()
        
        self.timer = Timer(fire: Date(), interval: (1.0/60.0), repeats: true, block: { (timer) in
            
            if let data = self.motionManagerDelegate.gyroData {
                let x = data.rotationRate.x
                let y = data.rotationRate.y
                let z = data.rotationRate.z
                
                self.value = "\(x) \(y) \(z)"
            }
            
        })
       
        RunLoop.current.add(self.timer!, forMode: .default)
    }
    
    func stopMotionTracking() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
            self.motionManagerDelegate.stopGyroUpdates()
        }
    }
}

