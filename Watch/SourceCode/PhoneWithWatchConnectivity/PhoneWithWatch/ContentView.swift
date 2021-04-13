//
//  ContentView.swift
//  PhoneWithWatch
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = ViewModelPhone()
    @State var reachable = "No"
    @State var messageText = ""
    
    var body: some View {
        VStack{
            Text("\(model.messageText)")
                .font(.title)
                .padding()
            
            Text("Reachable \(reachable)")
            
            Button(action: {
                if self.model.session.isReachable {
                    self.reachable = "Yes"
                }
                else{
                    self.reachable = "No"
                }
            }) {
                Text("Update")
            }
            
            TextField("Input your message", text: $messageText)
                .padding()
            Button(action: {
                self.model.session.sendMessage(["message" : self.messageText], replyHandler: nil) { (error) in
                    print(error.localizedDescription)
                }
                
            }) {
                Text("Send Message")
            }
        } //: VStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
