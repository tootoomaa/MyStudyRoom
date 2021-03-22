//
//  CreateHypedEventView.swift
//  UpcommingApp
//
//  Created by 김광수 on 2021/03/18.
//

import SwiftUI

struct CreateHypedEventView: View {
    
    @StateObject var hypedEvent = HypedEvent()
    @State var showTime: Bool = false
    @State var showImagePicker: Bool = false
    
    var body: some View {
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
            
            Section {
                if hypedEvent.imageData == nil {
                    HStack {
                        CreateHypedEventSectionView("camera", .purple, "Image")
                        Spacer()
                        Button(action: {
                            showImagePicker = true
                        }, label: {
                            Text("Pick Image")
                        })
                    }
                    Image("wwdc")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                } else {
                    HStack {
                        CreateHypedEventSectionView("camera", .purple, "Image")
                        Spacer()
                        Button(action: {
                            hypedEvent.imageData = nil
                        }, label: {
                            Text("remove Image")
                                .foregroundColor(.red)
                        })
                    }
                    hypedEvent.image()!
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
            }.sheet(isPresented: $showImagePicker, content: {
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
        }
    }
}

struct CreateHypedEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHypedEventView()
    }
}