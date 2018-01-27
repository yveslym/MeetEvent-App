//
//  MeetupCategories.swift
//  MeetEvent-App
//
//  Created by Matthew Harrilal on 1/21/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//struct MeetupCategories {
//    var name: String
//    var sortName: String
//    var shortname: String
//    init(name:String, sortName: String, shortname: String) {
//        self.name = name
//        self.sortName = sortName
//        self.shortname = shortname
//    }
//}
//
//extension MeetupCategories: Decodable {
//    enum SecondLayerKeys: String, CodingKey {
//        case name
//        case sortName = "sort_name"
//        case shortname
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: SecondLayerKeys.self)
//        let name = try container.decodeIfPresent(String.self, forKey: .name)
//        let sortName = try container.decodeIfPresent(String.self, forKey: .sortName)
//        let shortname = try container.decodeIfPresent(String.self, forKey: .shortname)
//        self.init(name: name!, sortName: sortName!, shortname: shortname!)
//    }
//}
//
//struct Results: Decodable {
//    let results:[MeetupCategories]
//}

@objc(Categories)
public class Categories: NSManagedObject, Decodable {
    enum FirstLayerKeys: String, CodingKey {
        case name, shortName, sortName = "sort_name"
    }
//
    convenience required public init(from decoder: Decoder) throws {
        let privateContext = CoreDataStack.singletonInstance.privateContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Categories", in: privateContext) else {
            fatalError()
        }
        self.init(entity: entity, insertInto: privateContext)
        let container = try decoder.container(keyedBy: FirstLayerKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.shortName = try container.decodeIfPresent(String.self, forKey: .shortName)
        self.sortName = try container.decodeIfPresent(String.self, forKey: .sortName)
        
    }







