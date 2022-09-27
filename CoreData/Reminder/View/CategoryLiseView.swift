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
    @State private var _showNoDelete = false
    @State private var _textEntered = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 10) {
                    List {
                        ForEach(_manager.categories, id: \.id) { category in
                            NavigationLink(destination: {
                                ItemListView(category: category)
                            }, label: {
                                Text("\(category.name) - \(category.number)") 
                            })
                        }
                        .onDelete(perform: self.removeRow)
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
            .alert(isPresented: $_showNoDelete) {
                Alert(title: Text("Delete Failed"),
                      message: Text("There are items currnetly attached to this category"),
                      dismissButton: .default(Text("OK"), action: { _showNoDelete = false }))
            } // Alert
            
        } //: NavigationView
    }
    
    private func removeRow(at offsets: IndexSet) {
        for offset in offsets {
            let category = _manager.categories[offset]
            
            if _manager.canDelete(category) {
                _manager.delete(category)
            } else {
                _showNoDelete = true
            }
        }
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
