//
//  ItemCell.swift
//  Reminder
//
//  Created by 김광수 on 2022/09/27.
//

import SwiftUI

struct ItemCell: View {
    
    @ObservedObject var itemCellVM: ItemCellViewModel
    
    var body: some View {
        HStack {
            Image(systemName: itemCellVM.item.completed
                  ? "checkmark.circle.fill"
                  : "circle")
            .resizable()
            .frame(width: 25, height: 25)
            .foregroundColor(itemCellVM.item.completed
                             ? .red
                             : Color(.lightGray))
            .onTapGesture {
                itemCellVM.item.completed.toggle()
                itemCellVM.savaItem()
            }
            
            TextField("Enter item name",
                      text: $itemCellVM.item.name,
                      onEditingChanged: { editing in
                if !editing, itemCellVM.item.name.isEmpty {
                    itemCellVM.deleteItem()
                }
            }, onCommit: { update(itemCellVM.item) })
        }
        .onDisappear {
            update(itemCellVM.item)
        }
    }
    
    private func update(_ item: Item) {
        if item.name.isEmpty {
            itemCellVM.deleteItem()
        } else {
            itemCellVM.savaItem()
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        let manager = ReminderManager.init(context: PersistenceController.shared.container.viewContext)
        ItemCell(
            itemCellVM: ItemCellViewModel(
                manager: manager,
                item: manager.newItem()
            )
        )
    }
}
