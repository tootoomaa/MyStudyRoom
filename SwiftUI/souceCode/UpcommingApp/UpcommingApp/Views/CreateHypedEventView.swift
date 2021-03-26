//
//  CreateHypedEventView.swift
//  UpcommingApp
//
//  Created by 김광수 on 2021/03/18.
//

import SwiftUI

struct CreateHypedEventView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var hypedEvent = HypedEvent()
    @State var showTime: Bool = false
    @State var showImagePicker: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    CreateHypedEventSectionView("keyboard", .blue, "title")
                    TextField("Family Vacation", text: $hypedEvent.title)
                        .autocapitalization(.words)
                }
                
                Section {
                    CreateHypedEventSectionView("calendar", .green, "Date")
                    DatePicker("Date",
                               selection: $hypedEvent.date,
                               displayedComponents: showTime ?  [.date,.hourAndMinute] : [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                    Toggle(isOn: $showTime, label: {
                        CreateHypedEventSectionView("clock.fill", .blue, "Time")
                    })
                }
                
                Button(action: {
                    showImagePicker.toggle()
                }, label: {
                    CreateHypedEventSectionView("camera", .purple, "Image")
                })
                .sheet(isPresented: $showImagePicker, content: {
                    ImagePicker(imageData: $hypedEvent.imageData)
                })
                
                Section {
                    HStack {
                        CreateHypedEventSectionView("paintpalette", .red, "Color")
                        ColorPicker("", selection: $hypedEvent.color)
                    }
                }
                
                Section {
                    CreateHypedEventSectionView("link", .orange, "URL")
                    TextField("Website", text: $hypedEvent.title)
                        .keyboardType(.URL)
                }
            }.navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: {
                DataController.shared.hypedEvents.append(hypedEvent)
                DataController.shared.saveData()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            }))
            .navigationTitle("Create")
        }
    }
}

struct CreateHypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }
}
