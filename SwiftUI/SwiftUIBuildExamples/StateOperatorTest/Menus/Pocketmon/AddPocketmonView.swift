//
//  AddPocketmonView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/29.
//

import SwiftUI

struct AddPocketmonView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var pocketmonViewModel: PocketmonListViewModel
    
    @State private var name: String = ""
    @State private var type: String = ""
    @State private var color: Color = .red
    
    @State var localFloat = 100.0
    let formatter = NumberFormatter()
    
    init(vm: PocketmonListViewModel ) {
        self.pocketmonViewModel = vm
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                HStack {
                    Text("이름")
                        .frame(width: 80, height: 60, alignment: .trailing)
                        .padding(.top, 10)
                    TextField("이름을 입력해주세요.", text: $name)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        
                }
                
                HStack {
                    Text("타입")
                        .frame(width: 80, height: 60, alignment: .trailing)
                    TextField("타입 입력해주세요.", text: $type)
                        .padding(.horizontal, 10)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                ColorPicker("Color", selection: $color)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 50)
                    .padding(.top, 10)
                
                TextField("Placeholder",
                          value: $localFloat,
                          formatter: formatter,
                          onEditingChanged: { isFirstResponder in
                            
                          }, onCommit: {
                            
                                print("put")
                            
                          }).padding(.horizontal, 30)
                    .keyboardType(.numberPad)
                
                Spacer()
                
                
            }
            .navigationTitle("Pocketmon Add")
            .navigationBarItems(trailing: Button("Add", action: {
                
                let maxNumber = pocketmonViewModel.pocketmons.map{$0.id}.max() ?? 100
                
                let pocketmon = Pocketmon(id: maxNumber+1,
                                          name: name,
                                          type: type,
                                          color: color)
                
                pocketmonViewModel.addPocketmon(new: pocketmon)
                
                self.presentationMode.wrappedValue.dismiss()
                
            }).disabled(name.isEmpty && type.isEmpty))
            .onAppear(perform: UIApplication.shared.handleKeyboard)
            
        }
    }
}

struct AddPocketmonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPocketmonView(vm: PocketmonListViewModel())
    }
}
