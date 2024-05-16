//
//  Item+CoreDataProperties.swift
//  Reminder
//
//  Created by 김광수 on 2022/09/27.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var category: Category?

}

extension Item : Identifiable {

}
