//
//  SettingView.swift
//  Abocados
//
//  Created by 김광수 on 2021/04/23.
//

import SwiftUI

struct SettingView: View {
    // MARK: - Properties
    @State private var enableNotification: Bool = true
    @State private var backgroundRefresh: Bool = false
        
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // MARK: - Header
            VStack {
                Image("avocado")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .center)
                    .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x: 0, y: 4)
                    
                Text("Avocaods".uppercased())
                    .font(.system(.title, design: .serif))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorGreenAdaptive"))
                
            } //: VSTACK
            .padding()
            
            Form {
                // MARK: - Section #1
                Section(header: Text("Greneral Setting")) {
                    Toggle("Enable Notification", isOn: $enableNotification)
                    Toggle("Background Refresh", isOn: $backgroundRefresh)
                }
                // MARK: - Section #2
                if backgroundRefresh {
                    Section(header: Text("Application")) {
                        HStack {
                            Text("Product").foregroundColor(Color.gray)
                            Spacer()
                            Text("Avocado Recipes")
                        }
                        HStack {
                            Text("Compatibility").foregroundColor(Color.gray)
                            Spacer()
                            Text("iPhone & iPad")
                        }
                        HStack {
                            Text("Developer").foregroundColor(Color.gray)
                            Spacer()
                            Text("Jack")
                        }
                        HStack {
                            Text("Design").foregroundColor(Color.gray)
                            Spacer()
                            Text("John")
                        }
                        HStack {
                            Text("Website").foregroundColor(Color.gray)
                            Spacer()
                            Text("Swift master class")
                        }
                        HStack {
                            Text("Version").foregroundColor(Color.gray)
                            Spacer()
                            Text("1.0.0")
                        }
                    }
                } else {
                    HStack {
                        Text("Personal message").foregroundColor(.gray)
                        Spacer()
                        Text("😱 Happy Coding!")
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
