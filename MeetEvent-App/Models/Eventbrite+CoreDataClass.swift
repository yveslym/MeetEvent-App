//
//  Eventbrite+CoreDataClass.swift
//  MeetEvent-App
//
//  Created by Yveslym on 2/2/18.
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
        self.id = map.optionalFrom("id")
        
        self.categoryID = map.optionalFrom("category_id")
        
        self.subCategoryID = map.optionalFrom("subcategory_id")
        
        created = map.optionalFrom("created")
        currency = map.optionalFrom("currency")
        endTime = map.optionalFrom("start.local")
        endTime = map.optionalFrom("end.local")
        eventUrl = map.optionalFrom("url")
        isFreeEvent = map.optionalFrom("is_free") ?? false
        logoID = map.optionalFrom("logo_id")
        status = map.optionalFrom("status")
        venueID = map.optionalFrom("venue_id")
       
        if logoID != nil{
        NetworkAdapter.request(target: .eventbriteLogo(logoID: Int(logoID!)!), success: { (response) in
            do{
            self.logoUrl = try response.mapString(atKeyPath: "url")
            }catch{
                
            }
        }, error: { (error) in
            
        }) { (error) in
            
        }
    }
    }
}








