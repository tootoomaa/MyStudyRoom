//
//  ItemViewModel.swift
//  Reminder
//
//  Created by 김광수 on 2022/09/27.
//

import Foundation

class ItemCellViewModel: ObservableObject {
    
    @Published var item: Item
    
    private var _manager: ReminderManager
    
    init(manager: ReminderManager, item: Item) {
        self._manager = manager
        self.item = item
    }
    
    func savaItem() {
        _manager.saveItem()
    }
    
    func deleteItem() {
        _manager.delete(item)
    }
    
}
