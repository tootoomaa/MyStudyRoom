//
//  ReminderManager.swift
//  Reminder
//
//  Created by 김광수 on 2022/09/26.
//

import SwiftUI
import CoreData

class ReminderManager: ObservableObject {
    
    private var _context: NSManagedObjectContext
    
    @Published var categories = [Category]()
    var newCategoryName: String = "" {
        didSet {
            if !newCategoryName.isEmpty {
                saveCatogory(name: newCategoryName)
            }
        }
    }
    
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
        save()
    }
    
    func delete(_ category: Category) {
        _context.delete(category)
        save()
    }
}
