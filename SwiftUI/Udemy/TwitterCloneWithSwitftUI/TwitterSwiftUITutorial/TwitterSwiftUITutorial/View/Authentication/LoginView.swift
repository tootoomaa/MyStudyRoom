//
//  LoginView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/22.
//

import SwiftUI

struct LoginView: View {
    // MARK: - Properties
    @State var email: String = ""
    @State var password: String = ""
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("twitter-logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 220, height: 220)
                        .padding(.top, 88)
                    
                    VStack {
                        CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                        CustomSecurityTextField(text: $password, placeholder: Text("Password"), imageName: "lock")
                            .padding()
                            .background(Color(.init(white: 1, alpha: 0.15)))
                            .cornerRadius(10)
                            .padding()
                    } //: VSTACK
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {}, label: {
                            Text("Forget Password?")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .padding(.top, 8)
                                .padding(.trailing, 32)
                        })
                    } //: HSTACK
                    
                    Button(action: {}, label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(width: 360, height: 50)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .padding()
                    })
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: RegistrationView(),
                        label: {
                            HStack {
                                Text("Don't Have an account?")
                                    .font(.system(size: 14))
                                Text("Sign up")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .padding(.bottom, 40)
                        })
                    
                } //: VSTACK
            } //: ZSTACK
            .background(Color(#colorLiteral(red: 0.1171132252, green: 0.6298289299, blue: 0.951243937, alpha: 1)))
            .ignoresSafeArea()
        } //: Navigation View
    }
}

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
