//
//  ContentView.swift
//  CleanArchitectureExample
//
//  Created by 김광수 on 2021/06/06.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State var number: Int = 0
    
    var body: some View {
        HStack {
            
            Button(action: {
                number += 1
            }, label: {
                Text("+").font(.title3)
            })
            
            Spacer()
            
            Text("\(appState.displayNumder.number)").font(.title)
            
            Spacer()
            
            Button(action: {
                number -= 1
            }, label: {
                Text("-").font(.title3)
            })
            
        } //: HStack
        .padding(.horizontal, 50)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
