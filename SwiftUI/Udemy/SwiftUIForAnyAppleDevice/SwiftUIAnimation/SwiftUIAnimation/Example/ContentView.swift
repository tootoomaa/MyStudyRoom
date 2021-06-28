//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by 김광수 on 2021/06/28.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var showDetailsOne: Bool = false
    @State private var showDetailsTwo: Bool = false
    
    var body: some View {
        VStack {
            Button("Press Me") {
                self.showDetailsOne.toggle()
            }
            
            HStack {
                if showDetailsOne {
                    Text("Hide Details")
                    Image(systemName: "chevron.up.square")
                } else {
                    Text("Show Details")
                    Image(systemName: "chevron.down.square")
                }
            }
            
            Button("Press Me(With Animation)") {
                self.showDetailsTwo.toggle()
            }
            .padding(.top, 50)
            
            HStack {
                Text(showDetailsTwo ? "Hide Details" : "Show Details")
                Image(systemName: "chevron.up.square")
                    .rotationEffect(.degrees(self.showDetailsTwo ? 0 : 180))
                    .animation(.default)
            }
        } //: VStack
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
