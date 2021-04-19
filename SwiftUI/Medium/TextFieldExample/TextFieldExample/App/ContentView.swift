//
//  ContentView.swift
//  TextFieldExample
//
//  Created by 김광수 on 2021/04/19.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var userViewModel = UserViewModel()
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $userViewModel.username)
                    .autocapitalization(.none)
            }
            Section {
                SecureField("Password", text: $userViewModel.password)
                SecureField("Password again", text: $userViewModel.passwordAgain)
            }
            Section {
                Button(action: { }) {
                    Text("Sign up")
                }
                .disabled(!userViewModel.isValid)
            }
            
            Text(userViewModel.passwordMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
