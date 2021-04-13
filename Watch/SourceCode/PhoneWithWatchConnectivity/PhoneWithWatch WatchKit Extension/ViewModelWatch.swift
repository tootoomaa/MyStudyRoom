//
//  ViewModelWatch.swift
//  PhoneWithWatch WatchKit Extension
//
//  Created by 김광수 on 2021/04/13.
//

import Foundation
import WatchConnectivity

class ViewModelWatch: NSObject, ObservableObject {
    
    var session: WCSession
    @Published var messageText = ""
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        
        self.session.delegate = self
        session.activate()
    }
    
}

extension ViewModelWatch: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("⌚️ Apple Watch Connnect Complete 🏳️‍🌈")
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        DispatchQueue.main.async {
            self.messageText = message["returnMessage"] as? String ?? "Unknown"
        }
        
    }
    
}
