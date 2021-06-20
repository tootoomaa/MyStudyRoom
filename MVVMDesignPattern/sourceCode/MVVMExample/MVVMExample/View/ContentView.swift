//
//  ContentView.swift
//  MVVMExample
//
//  Created by 김광수 on 2021/05/11.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    
    @ObservedObject var loginModel = LoginViewModel()
    @State var isDisable: Bool = true
    
    @State var isPresentNextPage: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {

                TextField("아이디", text: $loginModel.input.email)
                .textFieldStyle(DefaultTextFieldStyle())
                .frame(height: 50)
                
                TextField("패스워드", text: $loginModel.input.password)
                .frame(height: 50)
                
                Button(action: {
                    isPresentNextPage.toggle()
                }, label: {
                    Text("Login")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor(.white)
                        .background(isDisable ? Color.gray : Color.blue)
                        .cornerRadius(20)
                    
                }) //: Button
                .disabled(isDisable)
                .sheet(isPresented: $isPresentNextPage, content: {
                    LoginSuccessView(user: loginModel.user)
                })
            } // : VSTACK
            .navigationBarTitle("Login Page")
        } //: Navigation View
        .padding(.horizontal, 24)
        .onReceive(loginModel.output.$isDisable) { self.isDisable = $0 }
        /*
         onReceive는 ViewModel의 값을 통해서 UI를 변경할떄 사용한다.
         ** View를 변화시키는 역활은 @State **
         */
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
