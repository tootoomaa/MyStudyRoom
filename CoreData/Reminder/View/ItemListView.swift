//
//  ItemListView.swift
//  Reminder
//
//  Created by 김광수 on 2022/09/27.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject private var _manager: ReminderManager
    @State private var _showAddItem: Bool = false
    @State private var _hideCompletedItems: Bool = false
    private var _category: Category
    
    init(category: Category) {
        self._category = category
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            List {
                Section {
                    ForEach(_manager.items, id: \.id) { item in
                        if !_hideCompletedItems || !item.completed {
                            ItemCell(itemCellVM: ItemCellViewModel(manager: _manager,
                                                                   item: item))
                        }
                    } //: ForEach
                    .onDelete(perform: self.removeRow)
                    
                    if _showAddItem {
                        ItemCell(itemCellVM: ItemCellViewModel(manager: _manager,
                                                               item: _manager.newItem()))
                    }
                } header: {
                    HStack {
                        Text("Head Completed")
                            .font(.callout)
                            .fontWeight(.medium)
                        Spacer()
                        Toggle(isOn: $_hideCompletedItems, label: {})
                    }
                } //: Section
            } //: List
            .listStyle(InsetGroupedListStyle())
            
            HStack {
                Button(action: { _showAddItem.toggle() }, label: {
                    if _showAddItem {
                        Button(action: { _showAddItem.toggle() }, label: {
                            Text("Done")
                        })
                        .padding()
                    } else {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                            
                            Text("New Item")
                        }
                        .padding()
                    } //: If - else
                }) //: Button
            } //: HSTAKC
            .navigationTitle(self._category.name)
        } //: VSTACK
        .onAppear { _manager.category = _category }
    }
    
    private func removeRow(at offsets: IndexSet) {
        for offset in offsets {
            let item = _manager.items[offset]
            _manager.delete(item)
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(category: Category())
            .environmentObject(
                ReminderManager(context: PersistenceController.shared.container.viewContext)
            )
    }
}
