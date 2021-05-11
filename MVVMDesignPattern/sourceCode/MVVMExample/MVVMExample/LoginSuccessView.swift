//
//  LoginSuccessView.swift
//  MVVMExample
//
//  Created by 김광수 on 2021/05/11.
//

import SwiftUI

struct LoginSuccessView: View {
    // MARK: - Properties
    @State var user: User
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("아이디 : \(user.email)")
            
            Text("패스워드 : \(user.password)")
        }
    }
}

// MARK: - Preview
struct LoginSuccessView_Previews: PreviewProvider {
    
    static var user = User(email: "kwangsoo@Salphadex.com", password: "1234")
    
    static var previews: some View {
        LoginSuccessView(user: user)
    }
}
