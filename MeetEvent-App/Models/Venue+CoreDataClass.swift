//
//  Venue+CoreDataClass.swift
//  MeetEvent-App
//
//  Created by Yveslym on 1/29/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData
import Mapper

@objc(Venue)
public class Venue: NSManagedObject, Mappable {
    convenience required public init(map: Mapper) throws {
        
        let cont = CoreDataStack.singletonInstance.privateContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Venue", in: cont) else { fatalError() }
        
        self.init(entity: entity, insertInto: cont)
        self.name = map.optionalFrom("name")
        self.address = map.optionalFrom("address.localized_address_display")
        self.city = map.optionalFrom("address.city")
        self.country = map.optionalFrom("address.country")
        self.id = map.optionalFrom("id")
        self.longitude = map.optionalFrom("longitude")
        self.latitude = map.optionalFrom("latitude")
        self.region = map.optionalFrom("address.region")
        self.street = map.optionalFrom("address.street")
    }
    

}
