//
//  Category+CoreDataProperties.swift
//  Reminder
//
//  Created by 김광수 on 2022/09/26.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String

}

extension Category : Identifiable {

}
