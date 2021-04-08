//
//  SettingsView.swift
//  Fructus
//
//  Created by 김광수 on 2021/04/07.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isOnboarding") var inOnboarding: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                // MARK: - SESSION 1
                
                GroupBox(
                    label:
                        SettingsLabelView(labelText: "Furctus", labelImage: "info.circle")
                ) {
                    Divider().padding(.vertical, 4)
                    HStack(alignment: .center, spacing: 10) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .cornerRadius(9)
                        Text("Most Fruits are naturally low in fat, sodium, ad calories, slkfajsdklfjaklfjsadlkfjas,sadlfkj")
                            .font(.footnote)
                    }
                }
                
                // MARK: - SESSION 2
                
                GroupBox(
                    label: SettingsLabelView(labelText: "Customization", labelImage: "paintbrush")
                ) {
                    Divider().padding(.vertical, 4)
                    Text("if you wish, you can restart the application by toggle the switch in this box, That way it starts the onboarding process and you will see the welcome")
                        .padding(.vertical, 8)
                        .frame(minHeight: 60)
                        .layoutPriority(1)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    
                    Toggle(isOn: $inOnboarding) {
                        if inOnboarding {
                            Text("Restart".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.green)
                        } else {
                            Text("Restart".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.secondary)
                        }
                    }
                    .padding()
                    .background(
                        Color(UIColor.tertiarySystemBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    )
                    
                }
                
                // MARK: - SESSION 3
                GroupBox(
                    label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone")
                ) {
                    SettingsRowView(name: "Developer", content: "John / Jane")
                    SettingsRowView(name: "Designer", content: "Robert Petro")
                    SettingsRowView(name: "WebSide", linkLabel: "SwiftUI MasterClass", linkDestination: "swiftuimasterclass.com")
                    SettingsRowView(name: "Twitter", linkLabel: "@RobertPetras", linkDestination: "twitter.com/robertpetras")
                    SettingsRowView(name: "SwiftUI", content: "2.0")
                    SettingsRowView(name: "Version", content: "1.1.0")
                }
            } //: ScrollView
            .navigationBarTitle(Text("Settings"), displayMode: .large)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
            )
            .padding()
        } //: NavigationView
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11 Pro")
    }
}
