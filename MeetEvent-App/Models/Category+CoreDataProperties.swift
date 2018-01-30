//
//  Category+CoreDataProperties.swift
//  MeetEvent-App
//
//  Created by Yveslym on 1/29/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var displayName: String?
    @NSManaged public var subcategories: NSSet?

}

// MARK: Generated accessors for subcategories
extension Category {

    @objc(addSubcategoriesObject:)
    @NSManaged public func addToSubcategories(_ value: SubCategories)

    @objc(removeSubcategoriesObject:)
    @NSManaged public func removeFromSubcategories(_ value: SubCategories)

    @objc(addSubcategories:)
    @NSManaged public func addToSubcategories(_ values: NSSet)

    @objc(removeSubcategories:)
    @NSManaged public func removeFromSubcategories(_ values: NSSet)

}
