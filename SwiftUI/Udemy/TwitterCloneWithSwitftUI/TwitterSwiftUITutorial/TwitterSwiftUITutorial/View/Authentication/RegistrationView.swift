//
//  RegistrationView.swift
//  TwitterSwiftUITutorial
//
//  Created by 김광수 on 2021/06/22.
//

import SwiftUI

struct RegistrationView: View {
    // MARK: - Properties
    @State var email: String = ""
    @State var password: String = ""
    @State var fullName: String = ""
    @State var userName: String = ""
    @Environment(\.presentationMode) var mode
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                Image("plus_photo")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .scaledToFill()
                    .frame(width: 140, height: 140)
                    .padding(.top, 88)
                    .padding(.bottom, 16)
                
                VStack(spacing: 15) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    CustomTextField(text: $email, placeholder: Text("Full name"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    
                    CustomTextField(text: $email, placeholder: Text("UserName"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    
                    CustomSecurityTextField(text: $password, placeholder: Text("Password"), imageName: "lock")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                } //: VSTACK
                
                Button(action: {}, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(width: 360, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding()
                })
                
                Spacer()
                
                HStack {
                    
                    Text("Already have an account?")
                        .font(.system(size: 14))
                    
                    Text("Sign In")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.bottom, 40)
                .onTapGesture {
                    mode.wrappedValue.dismiss()
                }
                
            } //: VSTACK
        } //: ZSTACK
        .background(Color(#colorLiteral(red: 0.1171132252, green: 0.6298289299, blue: 0.951243937, alpha: 1)))
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
