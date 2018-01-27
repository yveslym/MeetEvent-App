//
//  Client-API.swift
//  MeetEvent-App
//
//  Created by Matthew Harrilal on 1/26/18.
//  Copyright © 2018 Yveslym. All rights reserved.
//

import Foundation
import UIKit
import Moya

enum Events {
//    case events
//    case location(id: Int)
//    case likes(id:Int)
      case meetupCategories( page: Int, key: String)
      case meetupEvents(key: String, page: Int, topic: String)
}
extension Events: TargetType {
    var baseURL: URL {
        var baseURL = URL(string: "https://api.meetup.com")
        return baseURL!
    }
    
    var path: String {
        switch self {
        case .meetupCategories:
             return "/2/categories"
        case .meetupEvents:
            return "/2/open_events"
        }
    
    }
    
    var method: Moya.Method {
        switch self {
        case .meetupCategories:
            return .get
        case .meetupEvents:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .meetupCategories: fallthrough
        case .meetupEvents: return "{}".data(using: String.Encoding.utf8)!
            
        }
    }
    
    var task: Task {
        switch self{
            
        case .meetupCategories( let page, let key):
            return .requestParameters(parameters: ["sign": "true", "page": page, "key": key], encoding: URLEncoding.default)
        case .meetupEvents(let page, let key, let topic):
            return .requestParameters(parameters: ["key": key, "topic": topic], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .meetupCategories: fallthrough
        case .meetupEvents: return [:]
        }
    }
    
    
}
