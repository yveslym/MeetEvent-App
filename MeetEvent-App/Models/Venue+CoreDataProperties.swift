//
//  Venue+CoreDataProperties.swift
//  MeetEvent-App
//
//  Created by Yveslym on 1/29/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData


extension Venue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Venue> {
        return NSFetchRequest<Venue>(entityName: "Venue")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int32
    @NSManaged public var street: String?
    @NSManaged public var city: String?
    @NSManaged public var region: String?
    @NSManaged public var country: String?
    @NSManaged public var address: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var eventbrite: Eventbrite?

}
