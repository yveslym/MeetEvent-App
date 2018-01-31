//
//  Eventbrite+CoreDataClass.swift
//  MeetEvent-App
//
//  Created by Yveslym on 1/29/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//
//

import Foundation
import CoreData
import Moya
import Mapper


public class Eventbrite: NSManagedObject, Mappable {
    
    convenience required public init(map: Mapper)throws{
     
        let cont = CoreDataStack.singletonInstance.privateContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Eventbrite", in: cont) else { fatalError() }
        
         self.init(entity: entity, insertInto: cont)
    
        name = map.optionalFrom("name.text")
        descriptions = map.optionalFrom("description.text")
        let id: String = map.optionalFrom("id")!
        self.id = Int32(id)!
        let categoryID: String = map.optionalFrom("category_id")!
        self.categoryID = Int32(categoryID)!
        let subCategoryID: String = map.optionalFrom("subcategory_id")!
        self.subCategoryID = Int32(subCategoryID)!
        created = map.optionalFrom("created")
        currency = map.optionalFrom("currency")
        endTime = map.optionalFrom("start.local")
        endTime = map.optionalFrom("end.local")
        eventUrl = map.optionalFrom("url")
        let isFree: String = map.optionalFrom("is_free")!
        self.isFreeEvent = isFree.toBool()!
        let logoID: String = map.optionalFrom("logo_id")!
        self.logoID = Int32(logoID)!
        status = map.optionalFrom("status")
        let venueID: String = map.optionalFrom("venue_id")!
        self.venueID = Int32(venueID)!
    }
}
