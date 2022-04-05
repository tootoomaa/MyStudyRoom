//
//  SettingsView.swift
//  PresentAndDismissTransitionTutorial
//
//  Created by 김광수 on 2022/04/05.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectino: Int = 1
    @State private var setDate = Date()
    @State private var timeZoneOverride = true
    @State private var volume: Double = 25.0
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    List {
                        // Date Picker
                        Section(header: Text("Date and Time").sectionHead()) {
                            DatePicker(selection: $setDate) {
                                Image(systemName: "calender.circle")
                            }
                        }
                        .foregroundColor(.black)
                        .listRowBackground(Color.orange)
                        
                        //Time zone Toggle
                        Section(header: Text("Time Zone Override").sectionHead()) {
                            Toggle(isOn: $timeZoneOverride) {
                                HStack {
                                    Image(systemName: "timer")
                                    Text("Overrride")
                                }
                            }
                        }
                        .foregroundColor(.black)
                        .listRowBackground(Color.orange)
                        
                        // alarm volume
                        Section(header: Text("Alarm Volume").sectionHead()) {
                            Text("Volume \(String(format: "%.0f", volume as Double)) Decibels")
                            Slider(value: $volume, in: 0...100) { _ in
                                // code to run when the slider is moved
                                
                            }
                        }
                        .foregroundColor(.black)
                        .listRowBackground(Color.orange)
                        
                        // replaet alarm
                        Section(header: Text("Repeat Alarm")) {
                            Picker(selection: $selectino, label: Text("Repeat Alarm: ")) {
                                Text("No Repeat").tag(1)
                                Text("Repeat Once").tag(2)
                                Text("Repeat Twice").tag(3)
                            }.foregroundColor(.black)
                        }.listRowBackground(Color.orange)
                        
                        // Save Button
                        Button { withAnimation(.easeInOut(duration: 1.0)) { self.show = false } } label: {
                            HStack {
                                Spacer()
                                Text("Save").bold().font(.title)
                                Spacer()
                            }
                        }
                        .listRowBackground(Color.green)
                        .foregroundColor(.white)
                    } //: List
                    .listStyle(InsetGroupedListStyle())
                } //: VStack
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("Settings")
            } //: NavigationView
        } //: ZStack
        .frame(width: 300, height: 650)
        .background(Color.white)
        .cornerRadius(20)
    }
}

extension Text {
    func sectionHead() -> Text {
        self.bold()
            .foregroundColor(.black)
            .font(.headline)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(show: .constant(true))
    }
}
