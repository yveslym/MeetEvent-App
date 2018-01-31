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
        guard let entity = NSEntityDescription.entity(forEntityName: "Eventbrite", in: cont) else { fatalError() }
        
        self.init(entity: entity, insertInto: cont)
    }
    

}
