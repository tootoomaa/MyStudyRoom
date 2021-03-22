//
//  LoginUserInputInterfaceView.swift
//  SwiftUIBuildTest
//
//  Created by 김광수 on 2021/03/22.
//

import SwiftUI

struct LoginUserInputInterfaceView: View {
    
    let title: String
    let placeHolder: String
    let isPasswd: Bool
    let textfieldImage: Image
    var bindValue: Binding<String>
    
    init(title: String,
         placeHolder: String,
         isPasswd: Bool,
         textfieldImage: Image,
         inputString: Binding<String>) {
        self.title = title
        self.placeHolder = placeHolder
        self.isPasswd = isPasswd
        self.textfieldImage = textfieldImage
        self.bindValue = inputString
    }
    
    var body: some View {
        
        VStack {
            HStack {
                Text(title)
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor(.green)
                    .padding(.bottom, 10)
                Spacer()
            }
            
            VStack {
                HStack {
                    textfieldImage
                        .foregroundColor(.gray)
                    if isPasswd {
                        SecureField(placeHolder, text: bindValue)
                        .padding(.bottom, 1)
                    } else {
                        TextField(placeHolder, text: bindValue)
                            .padding(.bottom, 1)
                    }
                }
                Divider()
                    .frame(maxWidth: .infinity, minHeight: 1,  maxHeight: 1, alignment: .center)
                    .background(Color.gray)
            }
        }
        .padding(.bottom, 30)
    }
}

struct LoginUserInputInterfaceView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            LoginUserInputInterfaceView(title: "환자 ID",
                                        placeHolder: "아이디",
                                        isPasswd: false,
                                        textfieldImage: Image(systemName: "person.fill"),
                                        inputString: .constant(""))
                .previewLayout(.fixed(width: 400, height: 100))
            
            LoginUserInputInterfaceView(title: "비밀번호",
                                        placeHolder: "패스워드",
                                        isPasswd: true,
                                        textfieldImage: Image(systemName: "lock"),
                                        inputString: .constant(""))
                .previewLayout(.fixed(width: 400, height: 100))
        }
    }
}
