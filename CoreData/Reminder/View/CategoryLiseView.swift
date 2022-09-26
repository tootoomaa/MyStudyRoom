//
//  CategoryLiseView.swift
//  Reminder
//
//  Created by 김광수 on 2022/09/26.
//

import SwiftUI

struct CategoryLiseView: View {
    
    @EnvironmentObject private var _manager: ReminderManager
    @State private var _showingAlert = false
    @State private var _textEntered = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 10) {
                    List {
                        ForEach(_manager.categories, id: \.id) { category in
                            Text(category.name)
                        }
                    } //: List
                    .listStyle(InsetGroupedListStyle())
                    
                    Spacer()
                    
                    HStack {
                        if !_showingAlert {
                            Button(action: { _showingAlert.toggle() }, label: {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25, alignment: .center)
                                    Text("New Category")
                                } //: HSTACK
                                .padding()
                                
                                Spacer()
                            }) //: Button
                        } //: HSTACK
                    } //: HSTACK
                } //: VSTACK
                if _showingAlert {
                    AlertView(textEntered: $_textEntered, showingAlert: $_showingAlert)
                        .onDisappear {
                            _manager.newCategoryName = _textEntered
                        }
                }
            } //: ZSTACK
            .navigationTitle("Categories")
            
        } //: NavigationView
    }
}

struct CategoryLiseView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryLiseView()
            .environmentObject(
                ReminderManager(
                    context: PersistenceController.shared.container.viewContext
                )
            )
    }
}
