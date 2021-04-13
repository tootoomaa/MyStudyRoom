//
//  ContentView.swift
//  PhoneWithWatch WatchKit Extension
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = ViewModelWatch()
    @State var reachable = "No"
    
    var body: some View {
        VStack {
            
            Text(model.messageText)
                .padding()
            Button(action: {
                
                self.model.session
                    .sendMessage(["returnMessage":"\(model.messageText) ok"], replyHandler: nil) { error in
                        print(error.localizedDescription)
                    }
                self.model.messageText = ""
                
            }, label: {
                Text("Remove")
                    .foregroundColor(.white)
                    
            }) //: Button
            .background(Color.green)
            .cornerRadius(20)
            
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
