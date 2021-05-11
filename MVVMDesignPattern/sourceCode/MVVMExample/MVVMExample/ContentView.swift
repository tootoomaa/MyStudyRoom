//
//  ContentView.swift
//  MVVMExample
//
//  Created by 김광수 on 2021/05/11.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State var email: String = ""
    @State var password: String = ""
    @State var isPresentNextPage: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {

                TextField("아이디", text: $email)
                .textFieldStyle(DefaultTextFieldStyle())
                .frame(height: 50)
                
                TextField("패스워드", text: $password)
                .frame(height: 50)
                
                Button(action: {
                    isPresentNextPage.toggle()
                }, label: {
                    Text("Login")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor(.white)
                        .background(email.isEmpty || password.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(20)
                    
                }) //: Button
                .disabled(email.isEmpty || password.isEmpty)
                .sheet(isPresented: $isPresentNextPage, content: {
                    LoginSuccessView(email: $email, password: $password)
                })
            } // : VSTACK
            .navigationBarTitle("Login Page")
        } //: Navigation View
        .padding(.horizontal, 24)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
