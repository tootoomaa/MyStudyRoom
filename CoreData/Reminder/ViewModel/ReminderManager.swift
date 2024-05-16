//
//  ReminderManager.swift
//  Reminder
//
//  Created by 김광수 on 2022/09/26.
//

import SwiftUI
import CoreData

class ReminderManager: ObservableObject {
    
    @Published var categories = [Category]()
    @Published var items = [Item]()
    
    private var _context: NSManagedObjectContext
    
    var newCategoryName: String = "" {
        didSet {
            if !newCategoryName.isEmpty {
                saveCatogory(name: newCategoryName)
            }
        }
    }
    
    var category: Category? {
        didSet {
            loadItems()
        }
    }
    
    var newItemName: String = "" {
        didSet {
            if !newItemName.isEmpty {
                saveItem()
            }
        }
    }
    
    //MARK: - Init
    init(context: NSManagedObjectContext) {
        self._context = context
        
        loadCategory()
    }
    
    private func save() {
        do {
            if _context.hasChanges {
                try _context.save()
            }
        } catch {
            print(error.localizedDescription)
            _context.rollback()
        }
        
        loadCategory()
    }
}

//MARK: - Category
extension ReminderManager {
    private func loadCategory() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            self.categories =  try _context.fetch(request)
        } catch {
            print("Error load categories: \(error.localizedDescription)")
            assertionFailure()
        }
    }
    
    private func saveCatogory(name: String) {
        let newCategory = Category(context: _context)
        newCategory.id = UUID()
        newCategory.name = name
        newCategory.number = 0
        save()
    }
    
    func delete(_ category: Category) {
        _context.delete(category)
        save()
    }
    
    func canDelete(_ category: Category) -> Bool {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(Item.category), category)
        do {
            return try _context.fetch(request).count == 0
        } catch {
            assertionFailure()
        }
        
        return false
    }
}

//MARK: - ITEM
extension ReminderManager {
    private func loadItems(_ filtedComplete: Bool = false) {
        guard let category = category else {
            assertionFailure("Category cannot be nil")
            return
        }
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(Item.category), category)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.name, ascending: true)]
        
        do {
            self.items = try _context.fetch(request)
            category.number = Int16(items.count)
        } catch {
            print("Error load items for \(category.name): \(error.localizedDescription)")
        }
    }
    
    func newItem() -> Item {
        guard let category = category else {
            assertionFailure("Category can not be nil")
            return Item()
        }
        
        let item = Item(context: _context)
        item.id = UUID()
        item.completed = false
        item.category = category
        
        return item
    }
    
    func saveItem() {
        _context.performAndWait {
            save() // Save 내부의 LoadCategory를 기다린다.
        }
        
        loadItems()
    }
    
    func delete(_ item: Item) {
        _context.performAndWait {
            _context.delete(item)
            save()
        }
        
        loadItems()
    }
    
    func filterOn(_ isOn: Bool) {
        self.loadItems(isOn)
    }
}
