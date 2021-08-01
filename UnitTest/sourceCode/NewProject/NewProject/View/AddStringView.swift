//
//  AddStringView.swift
//  NewProject
//
//  Created by 김광수 on 2021/08/01.
//

import SwiftUI

struct AddStringView: View {
    
    @State var newString: String = ""
    @Binding var isPresent: Bool
    
    var buttonAction: ((Item)->Void)
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            TextField("새로운 문자열 추가", text: $newString)
            
            Button(action: {
                isPresent.toggle()
                 buttonAction(getItem(newString))
            }, label: {
                Text("Save").foregroundColor(newString.isEmpty ? .gray :  .black)
            })
            .disabled(newString.isEmpty)
        } // VSTACK
        .padding(.horizontal, 30)
        .padding(30)
    }
    
    private func getItem(_ str: String) -> Item {
        Item(time: Date(), string: str)
    }
}

struct AddStringView_Previews: PreviewProvider {
    static var previews: some View {
        AddStringView(isPresent: .constant(true)) { _ in }
    }
}
