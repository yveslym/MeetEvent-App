//
//  Eventbrite+CoreDataProperties.swift
//  MeetEvent-App
//
//  Created by Yveslym on 1/29/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData


extension Eventbrite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Eventbrite> {
        return NSFetchRequest<Eventbrite>(entityName: "Eventbrite")
    }

    @NSManaged public var name: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var id: Int32
    @NSManaged public var eventUrl: String?
    @NSManaged public var startTime: String?
    @NSManaged public var endTime: String?
    @NSManaged public var created: String?
    @NSManaged public var status: String?
    @NSManaged public var currency: String?
    @NSManaged public var isFreeEvent: Bool
    @NSManaged public var venueID: Int32
    @NSManaged public var categoryID: Int32
    @NSManaged public var logoID: Int32
    @NSManaged public var organizerID: Int32
    @NSManaged public var logoUrl: String?
    @NSManaged public var venue: Venue?
     @NSManaged public var subCategoryID: Int32
    

}
