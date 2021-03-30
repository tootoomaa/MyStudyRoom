//
//  UpcommingView.swift
//  UpcommingApp
//
//  Created by 김광수 on 2021/03/18.
//

import SwiftUI

struct UpcommingView: View {
    
    @State var showingCreateView = false
    @ObservedObject var data = DataController.shared
    
    var body: some View {
        ScrollView {
            VStack {
                if data.hypedEvents.count == 0 {
                    Spacer()
                    Text("Nothing to look forwart to 😓 Create an event or chekc out the Discover tab!")
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.title)
                    
                } else {
                    ForEach(data.hypedEvents) { hypedEvent in
                        
                        HypedEventTitleView(hypedEvent: hypedEvent)
                        
                    }
                }
            }
        }
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
        UpcommingView()
    }
}
