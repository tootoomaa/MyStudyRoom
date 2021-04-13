//
//  ViewModelPhone.swift
//  PhoneWithWatch
//
//  Created by 김광수 on 2021/04/13.
//

import Foundation
import WatchConnectivity

class ViewModelPhone: NSObject, ObservableObject {

    var session: WCSession
    @Published var messageText = "Empty"
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
}

extension ViewModelPhone: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("📱 iPhone Activity Connect Finish")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("🅾️Become Inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("❌Did Deactivew")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        DispatchQueue.main.async {
            self.messageText = message["message"] as? String ?? "Unknown"
        }
        
    }
    
}

