//
//  WatchManager.swift
//  WatchTest
//
//  Created by 김광수 on 2022/09/02.
//

import Foundation
import WatchConnectivity

class WatchManager: ObservableObject {
    
    var wcSession: WCSession
    
    init() {
        self.wcSession = WCSession.default
        self.wcSession.delegate = self
        self.wcSession.activate()
    }
    
}

extension WatchManager: NSObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}
