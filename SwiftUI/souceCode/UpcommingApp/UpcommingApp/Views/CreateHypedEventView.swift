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
        Form {
            Section {
                CreateHypedEventSectionView("keyboard", "Title", .blue)
                TextField("Family Vacation", text: $hypedEvent.title)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
            }
            
            Section {
                CreateHypedEventSectionView("calendar", "Date", .red)
                DatePicker("Date",
                           selection: $hypedEvent.date,
                           displayedComponents: showTime ? [.date, .hourAndMinute] : [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                Toggle(isOn: $showTime) {
                    CreateHypedEventSectionView("clock.fill", "Time", .blue)
                }
            }
            
            Section {
                if hypedEvent.image() == nil {
                    HStack {
                        CreateHypedEventSectionView("camera", "Photo", .orange)
                        Spacer()
                        Button(action: {
                            showImagePicker = true
                        }) {
                            Text("Pick Image")
                        }
                    }
                } else {
                    HStack {
                        CreateHypedEventSectionView("camera", "Photo", .orange)
                        Spacer()
                        Button(action: {
                            hypedEvent.imageData = nil
                        }) {
                            Text("remove Image")
                                .foregroundColor(.red)
                        }.buttonStyle(BorderlessButtonStyle())
                    }
                    Button(action: {
                        showImagePicker = true
                    }) {
                        hypedEvent.image()!
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.buttonStyle(BorderlessButtonStyle())
                    
                }
            }.sheet(isPresented: $showImagePicker) {
                ImagePicker(imageData: $hypedEvent.imageData)
            }
            
            Section {
                CreateHypedEventSectionView("paintpalette", "Color", .red)
                ColorPicker("Color", selection: $hypedEvent.color)
            }
            
            Section {
                TextField("WebSide", text: $hypedEvent.url)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
                
        }
    }
}

struct CreateHypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }
}
