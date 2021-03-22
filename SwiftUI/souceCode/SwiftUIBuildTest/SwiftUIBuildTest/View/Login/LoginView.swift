//
//  ContentView.swift
//  SwiftUIBuildTest
//
//  Created by 김광수 on 2021/03/19.
//

import SwiftUI

struct LoginView: View {
    
    @State var id: String = ""
    @State var passwd: String = ""
    @State var autoLogin: Bool = false
    @State var isLinkActive = false
    @State var isValidated = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("로그인")
                    .foregroundColor(.green)
                    .bold()
                    .font(.system(size: 30))
                    .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 30, alignment: .leading)
                    .padding(.top, 50)
                
                Text("로그인 후 앱을 사용할 수 있습니다.")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                    .padding(.bottom, 40)
                
                
                LoginUserInputInterfaceView(title: "환자 ID",
                                            placeHolder: "아이디",
                                            isPasswd: false,
                                            textfieldImage: Image(systemName: "person.fill"),
                                            inputString: $id)
                
                LoginUserInputInterfaceView(title: "비밀번호",
                                            placeHolder: "패스워드",
                                            isPasswd: true,
                                            textfieldImage: Image(systemName: "lock"),
                                            inputString: $passwd)
                
                HStack {
                    Text("비밀번호")
                        .foregroundColor(.green)
                        .padding(.bottom, 10)
                    Spacer()
                }
                
                VStack {
                    
                    HStack {
                        Button(action: {
                            autoLogin.toggle()
                        }, label: {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(autoLogin ? .green : .gray)
                        }).frame(minHeight: 30, maxHeight: 30, alignment: .leading)
                        .padding(.bottom, 5)
                        
                        Text("Remember ID")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, minHeight: 30,
                                   maxHeight: 30, alignment: .leading)
                            .padding(.bottom, 5)
                    }
                    
                    NavigationLink(
                        destination: FindIDPasswordView(),
                        label: {
                            Text("환자 ID 또는 비밀번호 찾기")
                                .frame(maxWidth: .infinity, minHeight: 30,
                                       maxHeight: 30, alignment: .leading)
                                .font(.system(size: 15))
                                .foregroundColor(.green)
                        })
                    Spacer()
                    
                    NavigationLink(
                        destination: MainView(),
                        isActive: $isValidated,
                        label: {
                            Button("로그인") {
                                isValidated = (id == "Test") && (passwd == "passwd")
                            }
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.green)
                            .cornerRadius(10)
                            .clipped()
                        })
                }
            }.edgesIgnoringSafeArea(.all)
            .padding(.all, 30)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
