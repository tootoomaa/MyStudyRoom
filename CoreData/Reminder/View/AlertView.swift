//
//  AlertView.swift
//  Reminder
//
//  Created by 김광수 on 2022/09/26.
//

import SwiftUI

struct AlertView: View {
    //MARK: - Properties
    @Binding var textEntered: String
    @Binding private var showingAlert: Bool
    
    @State private var _editedText: String = ""
    
    //MARK: - Init
    init(textEntered: Binding<String>, showingAlert: Binding<Bool>) {
        self._textEntered = textEntered
        self._showingAlert = showingAlert
    }
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Text("Add Category")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.top, 15)
            
            TextField("Enter text", text: $_editedText,
                      onEditingChanged: { _ in },
                      onCommit: {
                textEntered = _editedText
                _editedText = ""
                showingAlert.toggle()
            })
            .padding(10)
            .background(Color(.lightGray).opacity(0.2))
            .cornerRadius(8)
            
            Divider()
            
            HStack {
                Spacer()
                Button("Cancel") {
                    _editedText = ""
                    textEntered = ""
                    showingAlert.toggle()
                } //: Cancel Button
                
                Spacer()
                Divider()
                Spacer()
                
                Button("Done") {
                    textEntered = _editedText
                    _editedText = ""
                    showingAlert.toggle()
                    
                } //: Done Button
                Spacer()
            }
        }
        .frame(width: 300, height: 150)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(textEntered: .constant(""), showingAlert: .constant(true))
    }
}
