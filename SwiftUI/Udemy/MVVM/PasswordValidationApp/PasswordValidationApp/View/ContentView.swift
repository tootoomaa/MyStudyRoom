//
//  ContentView.swift
//  PasswordValidationApp
//
//  Created by 김광수 on 2021/12/07.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var registrationVM = RegisterationViewModel()
    @State private var messages: [String] = []
    
    var body: some View {
        
        NavigationView {
            Form {
                VStack(spacing: 10) {
                    TextField("First name", text: $registrationVM.firstname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Last name", text: $registrationVM.lastname)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("User name", text: $registrationVM.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Password", text: $registrationVM.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Register") {
                        registrationVM.validate()
                    }.buttonStyle(PlainButtonStyle())
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(6)
                    .foregroundColor(Color.white)
                    
                    BrockenRulesView(brokenRules: registrationVM.brokenRules)
                    
                }
                .navigationBarTitle("Registeration")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
