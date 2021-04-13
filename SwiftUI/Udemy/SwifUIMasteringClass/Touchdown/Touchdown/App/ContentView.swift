//
//  ContentView.swift
//  Touchdown
//
//  Created by 김광수 on 2021/04/13.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    
    //MARK: - Body
    var body: some View {
        FooterView()
            .padding(.horizontal)
    }
}

//MARK: - preiview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
