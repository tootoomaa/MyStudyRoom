//
//  UpcommingView.swift
//  UpcommingApp
//
//  Created by 김광수 on 2021/03/18.
//

import SwiftUI

struct UpcommingView: View {
    
    @State var showingCreateView = false
    
    var body: some View {
        Text("Upcoming!")
            .navigationTitle("Upcoming")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        showingCreateView = true
                                    }, label: {
                                        Image(systemName: "calendar.badge.plus")
                                            .font(.title)
                                            .foregroundColor(.black)
                                    })
                                    .sheet(isPresented: $showingCreateView, content: {
                                        CreateHypedEventView()
                                    })
            )
    }
}

struct UpcommingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UpcommingView()
        }
    }
}
