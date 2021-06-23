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
    @State var showImagePciker = false
    @State var selectedUIImage: UIImage?
    @State var image: Image?
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel
    
    // MARK: - Handler
    func loadImage() {
        guard let selectedImage = selectedUIImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack {
                Button(action: { showImagePciker.toggle() }, label: {
                    ZStack {
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .padding(.top, 88)
                                .padding(.bottom, 16)
                        } else {
                            Image("plus_photo")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .padding(.top, 88)
                                .padding(.bottom, 16)
                        }
                    } //: ZSTACK
                }).sheet(isPresented: $showImagePciker,
                         onDismiss: loadImage, content: {
                            ImagePicker(image: $selectedUIImage)
                })
                
                // MARK: - Input Text Field
                VStack(spacing: 15) {
                    CustomTextField(text: $email, placeholder: Text("Email"), imageName: "envelope")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    CustomTextField(text: $fullName, placeholder: Text("Full name"), imageName: "person")
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.15)))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    
                    CustomTextField(text: $userName, placeholder: Text("UserName"), imageName: "person")
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
                
                Button(action: {
                    guard let image = selectedUIImage else { return }
                    viewModel.regiterUser(email: email, password: password, username: userName, fullname: fullName, profileImage: image)
                }, label: {
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
