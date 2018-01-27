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
public class MeetupCategories: NSManagedObject, Decodable {
    enum FirstLayerKeys: String, CodingKey {
        case name, shortName, sortName
    }
    
    convenience public required init(from decoder: Decoder) throws {
        <#code#>
    }
}










