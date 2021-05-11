//
//  LoginSuccessView.swift
//  MVVMExample
//
//  Created by 김광수 on 2021/05/11.
//

import SwiftUI

struct LoginSuccessView: View {
    // MARK: - Properties
    @Binding var email: String
    @Binding var password: String
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("아이디 : \(email)")
            
            Text("패스워드 : \(password)")
        }
    }
}

// MARK: - Preview
struct LoginSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSuccessView(email: .constant("kwangsoo@Salphadtx.com"),
                         password: .constant("testaaa"))
    }
}
