//
//  ContentView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/29.
//

import SwiftUI

struct PocketmonView: View {
    
    @ObservedObject var pocketmonListVM = PocketmonListViewModel()
    
    @State var isHide: Bool = true
    @State var addViewPresent: Bool = false
    
    var body: some View {
        NavigationView {
            List(pocketmonListVM.pocketmons, id: \.id) { pocketmonVM in
                HStack {
                    Text(pocketmonVM.name)
                    if !isHide {
                        Text(pocketmonVM.type)
                            .foregroundColor(pocketmonVM.color)
                    }
                }
            }
            .navigationBarTitle("PocketMon")
            .navigationBarItems(leading: Button(isHide ? "Show" : "Hide", action: {
                
                self.isHide.toggle()
                
            }), trailing: Button("Add", action: {
                
                self.addViewPresent = true
                
            }).sheet(isPresented: $addViewPresent, content: {
                AddPocketmonView(vm: pocketmonListVM)
            }))
            Spacer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PocketmonView()
    }
}

